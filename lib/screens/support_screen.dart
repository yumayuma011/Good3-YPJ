import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../l10n/l10n_extensions.dart';
import '../widgets/settings_widgets.dart';
import 'static_text_screen.dart';

/// 「サポート」詳細画面。お問い合わせ／FAQ／規約／プライバシー／
/// 特商法表記／OSSライセンス／データリセットへの導線をまとめる。
class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  // 問い合わせ先メールアドレスは言語に依存しないデータなのでARBには含めない
  static const _contactEmail = 'good3.things.jp@gmail.com';

  Future<void> _sendMail(BuildContext context) async {
    final uri = Uri(
      scheme: 'mailto',
      path: _contactEmail,
      query: 'subject=${Uri.encodeComponent(context.l10n.contactSubject)}',
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
          SectionLabel(l10n.settingsSupportSection),
          SettingsGroup(rows: [
            SettingsRow(
              label: l10n.supportContact,
              icon: Icons.mail_outline,
              onTap: () => _sendMail(context),
            ),
            // 今は表示しない
            // SettingsRow(
            //   label: l10n.supportFaq,
            //   icon: Icons.help_outline,
            //   onTap: () => _push(
            //     context,
            //     StaticTextScreen(
            //       title: l10n.supportFaq,
            //       body: l10n.faqBody,
            //     ),
            //   ),
            // ),
            SettingsRow(
              label: l10n.supportTerms,
              icon: Icons.description_outlined,
              onTap: () => _push(
                context,
                StaticTextScreen(
                  title: l10n.supportTerms,
                  body: l10n.termsBody,
                ),
              ),
            ),
            SettingsRow(
              label: l10n.supportPrivacy,
              icon: Icons.privacy_tip_outlined,
              onTap: () => _push(
                context,
                StaticTextScreen(
                  title: l10n.supportPrivacy,
                  body: l10n.privacyBody,
                ),
              ),
            ),
            SettingsRow(
              label: l10n.supportLegal,
              icon: Icons.gavel_outlined,
              onTap: () => _push(
                context,
                StaticTextScreen(
                  title: l10n.supportLegal,
                  body: l10n.legalBody,
                ),
              ),
            ),
            SettingsRow(
              label: l10n.supportOssLicense,
              icon: Icons.code,
              onTap: () => showLicensePage(
                context: context,
                applicationName: l10n.appTitle,
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
