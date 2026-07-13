import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/good_thing_entry.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';

/// 「2026 6.11 木 / 1 今日も生きていた」のような、日付＋いいこと一覧を表示するカード。
/// 記録画面・カレンダー画面の両方で使い回す。
class EntryDetailCard extends StatelessWidget {
  final GoodThingEntry entry;
  final EdgeInsetsGeometry margin;

  const EntryDetailCard({
    super.key,
    required this.entry,
    this.margin = const EdgeInsets.only(bottom: 12),
  });

  @override
  Widget build(BuildContext context) {
    final d = entry.date;
    final weekday = AppStrings.weekdaysMonFirst[d.weekday - 1];
    final dateLabel = '${d.year}.${d.month}.${d.day} ($weekday)';
    final items = entry.displayItems;

    return Container(
      margin: margin,
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimens.paddingL),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(AppDimens.radiusXL),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(AppDimens.cardShadowOpacity),
            blurRadius: AppDimens.cardShadowBlur,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.draw_outlined,
              size: AppDimens.iconL,
              color: AppColors.textSecondary
          ),
          SizedBox(width: 10),
          Text(
            dateLabel,
            style: AppTextStyles.entryDate,
          ),
            ],
          ),
          const SizedBox(height: 10),
          for (var i = 0; i < items.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _NumberBadge(number: i + 1),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      items[i],
                      style: AppTextStyles.entryItem,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _NumberBadge extends StatelessWidget {
  final int number;
  const _NumberBadge({required this.number});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.numberBadgeSize,
      height: AppDimens.numberBadgeSize,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.rowBackground,
        shape: BoxShape.circle,
      ),
      child: Text(
        '$number',
        style: AppTextStyles.numberBadgeSmall,
      ),
    );
  }
}

/// 日付入力欄用のフォーマッタ（yyyy/MM/dd）
String formatDateForField(DateTime date) =>
    DateFormat('yyyy/MM/dd').format(date);
