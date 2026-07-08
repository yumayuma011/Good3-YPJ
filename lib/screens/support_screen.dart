import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../widgets/settings_widgets.dart';
import 'static_text_screen.dart';

/// 「サポート」詳細画面。お問い合わせ／FAQ／規約／プライバシー／
/// 特商法表記／OSSライセンス／データリセットへの導線をまとめる。
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _sendMail() async {
    final uri = Uri(
      scheme: 'mailto',
      path: AppStrings.contactEmail,
      query: 'subject=${Uri.encodeComponent(AppStrings.contactSubject)}',
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => screen));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          AppStrings.appTitle,
          style: TextStyle(
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
          const SectionLabel(AppStrings.settingsSupportSection),
          SettingsGroup(rows: [
            SettingsRow(
              label: AppStrings.supportContact,
              icon: Icons.mail_outline,
              onTap: _sendMail,
            ),
            SettingsRow(
              label: AppStrings.supportFaq,
              icon: Icons.help_outline,
              onTap: () => _push(
                context,
                const StaticTextScreen(
                  title: AppStrings.supportFaq,
                  body: AppStrings.faqBody,
                ),
              ),
            ),
            SettingsRow(
              label: AppStrings.supportTerms,
              icon: Icons.description_outlined,
              onTap: () => _push(
                context,
                const StaticTextScreen(
                  title: AppStrings.supportTerms,
                  body: AppStrings.termsBody,
                ),
              ),
            ),
            SettingsRow(
              label: AppStrings.supportPrivacy,
              icon: Icons.privacy_tip_outlined,
              onTap: () => _push(
                context,
                const StaticTextScreen(
                  title: AppStrings.supportPrivacy,
                  body: AppStrings.privacyBody,
                ),
              ),
            ),
            SettingsRow(
              label: AppStrings.supportLegal,
              icon: Icons.gavel_outlined,
              onTap: () => _push(
                context,
                const StaticTextScreen(
                  title: AppStrings.supportLegal,
                  body: AppStrings.legalBody,
                ),
              ),
            ),
            SettingsRow(
              label: AppStrings.supportOssLicense,
              icon: Icons.code,
              onTap: () => showLicensePage(
                context: context,
                applicationName: AppStrings.appTitle,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
