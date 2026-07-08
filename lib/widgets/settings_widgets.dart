import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_text_styles.dart';

/// 「カスタマイズ」「サポート」のようなセクション見出し
class SectionLabel extends StatelessWidget {
  final String text;
  const SectionLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 20, 4, 8),
      child: Text(
        text,
        style: AppTextStyles.sectionLabel,
      ),
    );
  }
}

/// 設定画面・サポート画面で使う「アイコン＋ラベル ›」の1行
class SettingsRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback? onTap;
  final bool isFirst;
  final bool isLast;

  const SettingsRow({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(AppDimens.radiusL);
    final primary = Theme.of(context).colorScheme.primary;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.vertical(
        top: isFirst ? radius : Radius.zero,
        bottom: isLast ? radius : Radius.zero,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.rowBackground,
          borderRadius: BorderRadius.vertical(
            top: isFirst ? radius : Radius.zero,
            bottom: isLast ? radius : Radius.zero,
          ),
          border: isLast
              ? null
              : const Border(
                  bottom: BorderSide(color: AppColors.divider, width: 1),
                ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Icon(icon, size: AppDimens.iconL, color: primary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.rowLabel,
              ),
            ),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}

/// 複数の SettingsRow をまとめて角丸カードにする
class SettingsGroup extends StatelessWidget {
  final List<SettingsRow> rows;
  const SettingsGroup({super.key, required this.rows});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDimens.radiusL),
      child: Column(
        children: List.generate(rows.length, (i) {
          final r = rows[i];
          return SettingsRow(
            label: r.label,
            icon: r.icon,
            onTap: r.onTap,
            isFirst: i == 0,
            isLast: i == rows.length - 1,
          );
        }),
      ),
    );
  }
}
