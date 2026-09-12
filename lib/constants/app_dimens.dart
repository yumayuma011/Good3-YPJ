/// 余白・角丸・アイコンサイズなど、レイアウトに関する数値をまとめたファイル。
/// デザインを調整したいときはこのファイルの値だけ変更すれば全画面に反映される。
class AppDimens {
  AppDimens._();

  // 余白
  static const double paddingXS = 4;
  static const double paddingS = 8;
  static const double paddingM = 12;
  static const double paddingL = 16;
  static const double paddingXL = 20;
  static const double paddingXXL = 24;

  // 角丸
  static const double radiusS = 8;
  static const double radiusM = 10;
  static const double radiusL = 12;
  static const double radiusXL = 14;
  static const double radiusXXL = 16;
  static const double radiusPill = 20;

  // アイコンサイズ
  static const double iconS = 16;
  static const double iconM = 18;
  static const double iconL = 20;
  static const double iconXL = 24;

  // ボタン
  static const double buttonHeight = 48;
  static const double buttonHeightLarge = 52;

  // 記録画面の番号バッジ
  static const double numberBadgeSize = 20;
  static const double numberBadgeSizeLarge = 26;

  // カレンダー
  static const double calendarCellHeight = 44;
  static const double calendarCellCircle = 32;
  static const double calendarDotSize = 6;

  // 通知許可画面のアイコン
  static const double onboardingIconWrapperSize = 96;
  static const double onboardingIconSize = 48;

  // カード共通の影
  static const double cardShadowBlur = 6;
  static const double cardShadowOpacity = 0.04;
}
