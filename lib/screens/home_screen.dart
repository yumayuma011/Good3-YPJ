import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../widgets/view_toggle_pill.dart';
import 'record_screen.dart';
import 'calendar_screen.dart';
import 'settings_screen.dart';

/// 記録／カレンダーの2タブ＋設定アイコンを持つメイン画面。
///
/// AppBarの右側は現在のタブによって内容を切り替える。
/// ・記録タブ  → 設定画面への歯車アイコン
/// ・カレンダータブ → カレンダー表示/リスト表示の切り替えトグル（歯車は表示しない）
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabIndex = 0;

  /// カレンダータブ内の「カレンダー表示 / リスト表示」の状態。
  /// AppBar側のトグルから操作するため、ここ(親)で保持する。
  bool _isCalendarView = true;

  void _openSettings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCalendarTab = _tabIndex == 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          AppStrings.appTitle,
          style: AppTextStyles.appBarTitle,
        ),
        actions: [
          if (isCalendarTab)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ViewTogglePill(
                isCalendarView: _isCalendarView,
                onChanged: (value) =>
                    setState(() => _isCalendarView = value),
              ),
            )
          else
            IconButton(
              icon: const Icon(Icons.settings, color: AppColors.textPrimary),
              onPressed: _openSettings,
            ),
        ],
      ),
      body: IndexedStack(
        index: _tabIndex,
        children: [
          const RecordScreen(),
          CalendarScreen(
            isCalendarView: _isCalendarView,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabIndex,
        onTap: (i) => setState(() => _tabIndex = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.cardBackground,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.edit_note),
            label: AppStrings.navRecord,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_outlined),
            label: AppStrings.navCalendar,
          ),
        ],
      ),
    );
  }
}
