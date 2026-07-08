import 'package:flutter/material.dart';
import '../services/notification_service.dart';
import '../services/storage_service.dart';

/// 「デイリー通知設定」画面と連動する通知ON/OFF・時刻を保持するProvider。
class NotificationSettingProvider extends ChangeNotifier {
  final StorageService _storage;
  final NotificationService _notificationService;

  bool _enabled = false;
  TimeOfDay _time = const TimeOfDay(hour: 21, minute: 0);

  NotificationSettingProvider(this._storage, this._notificationService);

  bool get enabled => _enabled;
  TimeOfDay get time => _time;

  Future<void> load() async {
    _enabled = await _storage.loadNotifEnabled();
    final hhmm = await _storage.loadNotifTime();
    final parts = hhmm.split(':');
    _time = TimeOfDay(
      hour: int.tryParse(parts[0]) ?? 21,
      minute: int.tryParse(parts.length > 1 ? parts[1] : '0') ?? 0,
    );
    notifyListeners();
  }

  Future<void> setEnabled(bool value) async {
    _enabled = value;
    await _storage.saveNotifEnabled(value);
    if (value) {
      await _notificationService.scheduleDaily(_time);
    } else {
      await _notificationService.cancelDaily();
    }
    notifyListeners();
  }

  Future<void> setTime(TimeOfDay newTime) async {
    _time = newTime;
    final hhmm =
        '${newTime.hour.toString().padLeft(2, '0')}:${newTime.minute.toString().padLeft(2, '0')}';
    await _storage.saveNotifTime(hhmm);
    if (_enabled) {
      await _notificationService.scheduleDaily(newTime);
    }
    notifyListeners();
  }
}
