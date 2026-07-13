import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

/// カレンダー画面の「カレンダー表示 / リスト表示」切り替えに使う、
/// 丸みを帯びたピル型のトグルスイッチ。
/// 選択中のアイコンだけ白いカプセル型の背景が付き、
/// もう片方は背景なしでアイコンのみ表示される。
class ViewTogglePill extends StatelessWidget {
  final bool isCalendarView;
  final ValueChanged<bool> onChanged;

  const ViewTogglePill({
    super.key,
    required this.isCalendarView,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.rowBackground,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _PillIcon(
            icon: Icons.calendar_month_outlined,
            selected: isCalendarView,
            color: primary,
            onTap: () => onChanged(true),
          ),
          const SizedBox(width: 4),
          _PillIcon(
            icon: Icons.grid_view_rounded,
            selected: !isCalendarView,
            color: primary,
            onTap: () => onChanged(false),
          ),
        ],
      ),
    );
  }
}

class _PillIcon extends StatelessWidget {
  final IconData icon;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _PillIcon({
    required this.icon,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: 40,
        height: 32,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 4,
                    offset: const Offset(0, 1),
                  ),
                ]
              : null,
        ),
        child: Icon(
          icon,
          size: 18,
          color: selected ? color : AppColors.textSecondary,
        ),
      ),
    );
  }
}
