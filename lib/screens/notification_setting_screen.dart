import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/notification_setting_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../widgets/settings_widgets.dart';

/// 設定 > カスタマイズ > デイリー通知設定 画面。
/// 通知のON/OFFと通知時刻を変更できる。
class NotificationSettingScreen extends StatelessWidget {
  const NotificationSettingScreen({super.key});

  Future<void> _pickTime(BuildContext context) async {
    final provider = context.read<NotificationSettingProvider>();
    final picked = await showTimePicker(
      context: context,
      initialTime: provider.time,
      helpText: AppStrings.pickTimeHelp,
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.ok,
    );
    if (picked != null) {
      await provider.setTime(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationSettingProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(AppStrings.notifSettingTitle,
            style: TextStyle(color: AppColors.textPrimary)),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.paddingL),
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.rowBackground,
              borderRadius: BorderRadius.circular(AppDimens.radiusL),
            ),
            child: SwitchListTile(
              title: const Text(
                AppStrings.notifEnableLabel,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary),
              ),
              value: provider.enabled,
              activeColor: Theme.of(context).colorScheme.primary,
              onChanged: (v) => provider.setEnabled(v),
            ),
          ),
          const SizedBox(height: AppDimens.paddingM),
          if (provider.enabled)
            SettingsGroup(rows: [
              SettingsRow(
                label:
                    '${AppStrings.notifTimeLabelPrefix}${provider.time.hour.toString().padLeft(2, '0')}:${provider.time.minute.toString().padLeft(2, '0')}',
                icon: Icons.access_time,
                onTap: () => _pickTime(context),
              ),
            ]),
        ],
      ),
    );
  }
}
