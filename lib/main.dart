import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'providers/entries_provider.dart';
import 'providers/notification_setting_provider.dart';
import 'providers/theme_color_provider.dart';
import 'screens/home_screen.dart';
import 'screens/notification_permission_screen.dart';
import 'services/notification_service.dart';
import 'services/storage_service.dart';
import 'constants/app_colors.dart';
import 'constants/app_strings.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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
            title: AppStrings.appTitle,
            debugShowCheckedModeBanner: false,
            // 日付選択ダイアログ(showDatePicker)などの標準UIを日本語表示にする設定
            locale: const Locale('ja'),
            supportedLocales: const [
              Locale('ja'),
              Locale('en'),
            ],
            localizationsDelegates: const [
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
