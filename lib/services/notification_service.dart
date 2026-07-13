import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;
import '../l10n/generated/app_localizations.dart';

/// デイリー通知（毎日決まった時刻にリマインドする通知）を管理するサービス。
///
/// 注意: flutter_local_notifications / permission_handler は
/// バージョンによってAPIが変わることがあるため、
/// `flutter pub get` 後にエディタの警告が出た場合は
/// 各パッケージの最新READMEに合わせて微調整してください。
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const int _dailyNotificationId = 1001;

  bool _initialized = false;

  /// 端末の言語設定から対応するAppLocalizationsを解決する。
  /// この通知サービスはBuildContextを持たないため、gen_l10nが生成する
  /// トップレベル関数lookupAppLocalizationsを直接使う。
  AppLocalizations _resolveL10n() {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;
    final matched = AppLocalizations.supportedLocales.firstWhere(
      (l) => l.languageCode == deviceLocale.languageCode,
      orElse: () => const Locale('ja'),
    );
    return lookupAppLocalizations(matched);
  }

  Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    // 端末のローカルタイムゾーンをそのまま使う簡易実装。
    // 正確なタイムゾーン名が必要な場合は flutter_timezone 等の併用を検討。
    tz.setLocalLocation(tz.getLocation('Asia/Tokyo'));

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(initSettings);
    _initialized = true;
  }

  /// 通知の許可をリクエストする。true が返れば許可された。
  Future<bool> requestPermission() async {
    await init();

    // iOS
    final iosPlugin = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (iosPlugin != null) {
      final result = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      if (result != null) return result;
    }

    // Android 13以降
    final androidPlugin = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (androidPlugin != null) {
      final granted = await androidPlugin.requestNotificationsPermission();
      if (granted != null) return granted;
    }

    // permission_handler によるフォールバック
    final status = await Permission.notification.request();
    return status.isGranted;
  }

  /// 毎日 [time] に通知をスケジュールする
  Future<void> scheduleDaily(TimeOfDay time) async {
    await init();
    await _plugin.cancel(_dailyNotificationId);

    final now = tz.TZDateTime.now(tz.local);
    var scheduled = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    if (scheduled.isBefore(now)) {
      scheduled = scheduled.add(const Duration(days: 1));
    }

    final l10n = _resolveL10n();
    final details = NotificationDetails(
      android: AndroidNotificationDetails(
        'daily_reminder_channel',
        l10n.dailyNotificationChannelName,
        channelDescription: l10n.dailyNotificationChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
    );

    await _plugin.zonedSchedule(
      _dailyNotificationId,
      l10n.dailyNotificationTitle,
      l10n.dailyNotificationBody,
      scheduled,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time, // 毎日繰り返し
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  Future<void> cancelDaily() async {
    await init();
    await _plugin.cancel(_dailyNotificationId);
  }
}
