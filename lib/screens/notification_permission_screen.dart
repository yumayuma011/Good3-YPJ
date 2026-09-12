import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_setting_provider.dart';
import '../services/storage_service.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_text_styles.dart';
import '../l10n/l10n_extensions.dart';
import 'home_screen.dart';

/// アプリ初回起動時に最初に表示する、デイリー通知の許可を求める画面。
/// ログイン画面は無し。ここが最初の画面になる。
class NotificationPermissionScreen extends StatefulWidget {
  const NotificationPermissionScreen({super.key});

  @override
  State<NotificationPermissionScreen> createState() =>
      _NotificationPermissionScreenState();
}

class _NotificationPermissionScreenState
    extends State<NotificationPermissionScreen> {
  bool _isRequesting = false;

  Future<void> _finishOnboarding() async {
    final storage = StorageService();
    await storage.saveNotifPermissionAsked(true);
    if (!mounted) return;
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeScreen()),
    );
  }

  Future<void> _onAllowPressed() async {
    setState(() => _isRequesting = true);
    final settingProvider = context.read<NotificationSettingProvider>();
    try {
      await settingProvider.setEnabled(true);
    } finally {
      if (mounted) setState(() => _isRequesting = false);
    }
    await _finishOnboarding();
  }

  Future<void> _onSkipPressed() async {
    await _finishOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: AppDimens.onboardingIconWrapperSize,
                height: AppDimens.onboardingIconWrapperSize,
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.notifications_active_outlined,
                  size: AppDimens.onboardingIconSize,
                  color: primary,
                ),
              ),
              const SizedBox(height: 32),
              Text(
                context.l10n.notifPermissionTitle,
                textAlign: TextAlign.center,
                style: AppTextStyles.screenHeading,
              ),
              const SizedBox(height: 16),
              Text(
                context.l10n.notifPermissionBody,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyText,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: AppDimens.buttonHeightLarge,
                child: ElevatedButton(
                  onPressed: _isRequesting ? null : _onAllowPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusL),
                    ),
                  ),
                  child: _isRequesting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(context.l10n.notifPermissionAllow,
                          style: const TextStyle(fontSize: 15)),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: _isRequesting ? null : _onSkipPressed,
                child: Text(
                  context.l10n.notifPermissionSkip,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
