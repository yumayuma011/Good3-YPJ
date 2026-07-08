import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/good_thing_entry.dart';
import '../providers/entries_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../widgets/entry_detail_card.dart';

/// 「カレンダー」タブの中身。カレンダー表示とリスト表示は
/// [isCalendarView] で親(HomeScreen)から制御される
/// （切り替えトグルはAppBar側に表示されるため、ここには置かない）。
class CalendarScreen extends StatefulWidget {
  final bool isCalendarView;

  const CalendarScreen({super.key, required this.isCalendarView});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedMonth =
      DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime _selectedDate = GoodThingEntry.normalizeDate(DateTime.now());

  /// リスト表示で折りたたまれている月（yyyyMM形式の整数キー）
  final Set<int> _collapsedMonths = {};

  DateTime get _today => GoodThingEntry.normalizeDate(DateTime.now());

  void _changeMonth(int diff) {
    setState(() {
      _focusedMonth =
          DateTime(_focusedMonth.year, _focusedMonth.month + diff, 1);
    });
  }

  void _toggleMonth(int monthKey) {
    setState(() {
      if (_collapsedMonths.contains(monthKey)) {
        _collapsedMonths.remove(monthKey);
      } else {
        _collapsedMonths.add(monthKey);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final entriesProvider = context.watch<EntriesProvider>();

    return widget.isCalendarView
        ? _buildCalendarView(entriesProvider)
        : _buildListView(entriesProvider);
  }

  Widget _buildCalendarView(EntriesProvider provider) {
    final selectedEntry = provider.entryForDate(_selectedDate);
    final datesWithEntries = provider.datesWithEntries;

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingL,
        AppDimens.paddingS,
        AppDimens.paddingL,
        AppDimens.paddingXXL,
      ),
      children: [
        Container(
          padding: const EdgeInsets.all(AppDimens.paddingL),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: () => _changeMonth(-1),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text('${_focusedMonth.year}  ',
                          style: AppTextStyles.fieldLabel
                              .copyWith(fontSize: 14)),
                      Text('${_focusedMonth.month}月',
                          style: AppTextStyles.screenHeading
                              .copyWith(fontSize: 22)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: () => _changeMonth(1),
                  ),
                ],
              ),
              Row(
                children: AppStrings.weekdayHeaders
                    .map((w) => Expanded(
                          child: Center(
                            child: Text(w, style: AppTextStyles.caption),
                          ),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 4),
              _buildMonthGrid(datesWithEntries),
            ],
          ),
        ),
        const SizedBox(height: 16),
        if (selectedEntry != null)
          EntryDetailCard(entry: selectedEntry, margin: EdgeInsets.zero)
        else
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimens.paddingXL),
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(AppDimens.radiusXL),
            ),
            child: const Text(
              AppStrings.calendarNoEntry,
              style: AppTextStyles.emptyState,
            ),
          ),
      ],
    );
  }

  Widget _buildMonthGrid(Set<DateTime> datesWithEntries) {
    final firstDayOfMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1);
    final daysInMonth =
        DateTime(_focusedMonth.year, _focusedMonth.month + 1, 0).day;
    // weekday: Mon=1..Sun=7 -> 日曜始まりのオフセットに変換
    final leadingEmpty = firstDayOfMonth.weekday % 7;

    final totalCells = leadingEmpty + daysInMonth;
    final rows = (totalCells / 7).ceil();
    final today = _today;

    return Column(
      children: List.generate(rows, (row) {
        return Row(
          children: List.generate(7, (col) {
            final cellIndex = row * 7 + col;
            final dayNum = cellIndex - leadingEmpty + 1;
            if (dayNum < 1 || dayNum > daysInMonth) {
              return const Expanded(
                child: SizedBox(height: AppDimens.calendarCellHeight),
              );
            }
            final date =
                DateTime(_focusedMonth.year, _focusedMonth.month, dayNum);
            // 未来日付は選択できないようにする
            final isFuture = date.isAfter(today);
            final isSelected = !isFuture &&
                date.year == _selectedDate.year &&
                date.month == _selectedDate.month &&
                date.day == _selectedDate.day;
            final hasEntry = !isFuture &&
                datesWithEntries.any((d) =>
                    d.year == date.year &&
                    d.month == date.month &&
                    d.day == date.day);

            return Expanded(
              child: GestureDetector(
                onTap: isFuture
                    ? null
                    : () => setState(() => _selectedDate = date),
                child: SizedBox(
                  height: AppDimens.calendarCellHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: AppDimens.calendarCellCircle,
                        height: AppDimens.calendarCellCircle,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primary
                              : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '$dayNum',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                            color: isSelected
                                ? Colors.white
                                : (isFuture
                                    ? AppColors.divider
                                    : AppColors.textPrimary),
                          ),
                        ),
                      ),
                      if (hasEntry && !isSelected)
                        const Positioned(
                          top: 2,
                          child: _Dot(),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildListView(EntriesProvider provider) {
    final entries = provider.entriesAsc;
    if (entries.isEmpty) {
      return const Center(
        child: Text(AppStrings.recordEmpty, style: AppTextStyles.emptyState),
      );
    }

    // 月ごとにグループ化する（表示順を保つため順番にキーを積む）
    final monthKeys = <int>[];
    final groupedEntries = <int, List<GoodThingEntry>>{};
    for (final entry in entries) {
      final monthKey = entry.date.year * 100 + entry.date.month;
      if (!groupedEntries.containsKey(monthKey)) {
        groupedEntries[monthKey] = [];
        monthKeys.add(monthKey);
      }
      groupedEntries[monthKey]!.add(entry);
    }

    final widgets = <Widget>[];
    for (var i = 0; i < monthKeys.length; i++) {
      final monthKey = monthKeys[i];
      final monthEntries = groupedEntries[monthKey]!;
      final year = monthKey ~/ 100;
      final month = monthKey % 100;
      final isCollapsed = _collapsedMonths.contains(monthKey);
      final color =
          AppColors.monthPillColors[i % AppColors.monthPillColors.length];

      widgets.add(_MonthPill(
        label: '$year / $month',
        color: color,
        expanded: !isCollapsed,
        onTap: () => _toggleMonth(monthKey),
      ));

      widgets.add(AnimatedCrossFade(
        firstChild: Column(
          children: [
            for (final entry in monthEntries) EntryDetailCard(entry: entry),
          ],
        ),
        secondChild: const SizedBox(width: double.infinity),
        crossFadeState: isCollapsed
            ? CrossFadeState.showSecond
            : CrossFadeState.showFirst,
        duration: const Duration(milliseconds: 200),
        sizeCurve: Curves.easeInOut,
      ));
    }

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppDimens.paddingL,
        AppDimens.paddingS,
        AppDimens.paddingL,
        AppDimens.paddingXXL,
      ),
      children: widgets,
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppDimens.calendarDotSize,
      height: AppDimens.calendarDotSize,
      decoration: const BoxDecoration(
        color: Color(0xFF3E9E96),
        shape: BoxShape.circle,
      ),
    );
  }
}

class _MonthPill extends StatelessWidget {
  final String label;
  final Color color;
  final bool expanded;
  final VoidCallback onTap;

  const _MonthPill({
    required this.label,
    required this.color,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.radiusPill),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.06),
          borderRadius: BorderRadius.circular(AppDimens.radiusPill),
          border: Border.all(color: color, width: 1.5),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(label, style: AppTextStyles.monthPill.copyWith(color: color)),
            const SizedBox(width: 6),
            Icon(
              expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              color: color,
              size: AppDimens.iconM,
            ),
          ],
        ),
      ),
    );
  }
}
