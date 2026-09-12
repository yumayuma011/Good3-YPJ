import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../providers/entries_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_text_styles.dart';
import '../l10n/l10n_extensions.dart';
import '../widgets/settings_widgets.dart';
import 'color_picker_screen.dart';
import 'notification_setting_screen.dart';
import 'support_screen.dart';
// import 'data_import_export_screen.dart'; // インポート/エクスポート機能は今は表示しない

/// 設定画面。カスタマイズ／データ／サポート／おすすめのアプリを表示する。
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    try {
      final info = await PackageInfo.fromPlatform();
      if (mounted) {
        setState(() => _version = '${info.version} (${info.buildNumber})');
      }
    } catch (_) {
      if (mounted) setState(() => _version = '1.0.0');
    }
  }

  Future<void> _confirmResetAllData() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(context.l10n.resetConfirmTitle),
        content: Text(context.l10n.resetConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(context.l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(context.l10n.resetConfirmDelete,
                style: const TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await context.read<EntriesProvider>().resetAll();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.resetDoneSnackbar)),
        );
      }
    }
  }

  void _push(Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          l10n.appTitle,
          style: const TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(
          AppDimens.paddingL,
          0,
          AppDimens.paddingL,
          AppDimens.paddingXXL,
        ),
        children: [
          SectionLabel(l10n.settingsCustomizeSection),
          SettingsGroup(rows: [
            SettingsRow(
              label: l10n.settingsColorChange,
              icon: Icons.palette_outlined,
              onTap: () => _push(const ColorPickerScreen()),
            ),
            SettingsRow(
              label: l10n.settingsDailyNotification,
              icon: Icons.notifications_outlined,
              onTap: () => _push(const NotificationSettingScreen()),
            ),
          ]),
          // 今は表示しない
          // SectionLabel(l10n.settingsDataSection),
          // SettingsGroup(rows: [
          //   SettingsRow(
          //     label: l10n.settingsImport,
          //     icon: Icons.file_download_outlined,
          //     onTap: () => _push(
          //         const DataImportExportScreen(mode: DataIOMode.import)),
          //   ),
          //   SettingsRow(
          //     label: l10n.settingsExport,
          //     icon: Icons.file_upload_outlined,
          //     onTap: () => _push(
          //         const DataImportExportScreen(mode: DataIOMode.export)),
          //   ),
          // ]),
          SectionLabel(l10n.settingsSupportSection),
          SettingsGroup(rows: [
            SettingsRow(
              label: l10n.settingsSupport,
              icon: Icons.support_agent_outlined,
              onTap: () => _push(const SupportScreen()),
            ),
          ]),
          SectionLabel(l10n.settingsManageDataSection),
          SettingsGroup(rows: [
            SettingsRow(
              label: l10n.settingsResetAll,
              icon: Icons.delete_outline,
              onTap: _confirmResetAllData,
            ),
          ]),
          SectionLabel(l10n.settingsRecommendedApps),
          // 他アプリのおすすめ枠（必要に応じて内容を差し替えてください）
          Container(
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              border: Border.all(color: AppColors.divider),
              borderRadius: BorderRadius.circular(AppDimens.radiusL),
            ),
            child: Column(
              children: List.generate(3, (i) {
                return Container(
                  height: 96,
                  decoration: i < 2
                      ? const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(color: AppColors.divider)))
                      : null,
                );
              }),
            ),
          ),
          const SizedBox(height: AppDimens.paddingXXL),
          Center(
            child: Text(
              'ⓘ ${l10n.settingsVersion(_version)}',
              style: AppTextStyles.caption,
            ),
          ),
        ],
      ),
    );
  }
}
