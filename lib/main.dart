import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'providers/entries_provider.dart';
import 'providers/notification_setting_provider.dart';
import 'providers/theme_color_provider.dart';
import 'screens/home_screen.dart';
import 'screens/notification_permission_screen.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';
import 'constants/app_colors.dart';
import 'l10n/generated/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ja');
  await initializeDateFormatting('en');
  await initializeDateFormatting('ko');
  await Supabase.initialize(
    url: 'https://mbblhfcpinfvjmtbedlo.supabase.co',
    publishableKey: 'sb_publishable_nclldjEhpDlFgjX6fLr1Lw_7bVBCBB7',
  );
  runApp(const KyouNoIikotoApp());
}

class KyouNoIikotoApp extends StatelessWidget {
  const KyouNoIikotoApp({super.key});

  @override
  Widget build(BuildContext context) {
    final storageService = StorageService();
    final notificationService = NotificationService();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => EntriesProvider(storageService)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => ThemeColorProvider(storageService)..load(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationSettingProvider(
            storageService,
            notificationService,
          )..load(),
        ),
      ],
      child: Consumer<ThemeColorProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
            debugShowCheckedModeBanner: false,
            // locale は指定せず、端末の言語設定に自動追従させる
            supportedLocales: const [
              Locale('ja'),
              Locale('ko'),
              Locale('en'),
              Locale('en', 'US'),
              Locale('en', 'CA'),
              Locale('en', 'AU'),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              useMaterial3: true,
              scaffoldBackgroundColor: AppColors.background,
              colorScheme: ColorScheme.fromSeed(
                seedColor: themeProvider.primaryColor,
                primary: themeProvider.primaryColor,
              ),
              fontFamily: 'NotoSansJP',
              // 画面遷移をiOS風のスワイプ戻り対応にする
              // （Android等でも設定画面から記録画面へ「右スワイプで戻る」操作ができるようにする）
              pageTransitionsTheme: const PageTransitionsTheme(
                builders: {
                  TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.windows: CupertinoPageTransitionsBuilder(),
                  TargetPlatform.linux: CupertinoPageTransitionsBuilder(),
                },
              ),
            ),
            home: const _AppEntryPoint(),
          );
        },
      ),
    );
  }
}

/// アプリ起動直後の分岐役。
/// 「デイリー通知の許可画面」を一度も見せていなければそれを最初に表示し、
/// 一度でも見せたことがあればそのままホーム画面(記録/カレンダー)へ進む。
/// ※ログイン画面は無し。
class _AppEntryPoint extends StatelessWidget {
  const _AppEntryPoint();

  @override
  Widget build(BuildContext context) {
    final storageService = StorageService();
    return FutureBuilder<bool>(
      future: storageService.loadNotifPermissionAsked(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final alreadyAsked = snapshot.data!;
        return alreadyAsked
            ? const HomeScreen()
            : const NotificationPermissionScreen();
      },
    );
  }
}
