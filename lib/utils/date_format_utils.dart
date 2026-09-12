import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

/// カレンダーグリッドの曜日ヘッダー（日曜始まり、ロケール依存）
List<String> weekdayHeaders(Locale locale) {
  return DateFormat.EEEEE(locale.toString()).dateSymbols.NARROWWEEKDAYS;
}

/// 特定の日付の曜日表示（例: "木" / "Thu" / "목"）
String weekdayAbbreviation(DateTime date, Locale locale) =>
    DateFormat.E(locale.toString()).format(date);

/// 記録カードの日付ラベル（例: "2026/7/13 (木)"）
String formatEntryDateLabel(DateTime d, Locale locale) {
  final datePart = DateFormat.yMd(locale.toString()).format(d);
  final weekday = weekdayAbbreviation(d, locale);
  return '$datePart ($weekday)';
}

/// 日付入力欄用のフォーマッタ
String formatDateForField(DateTime date, Locale locale) =>
    DateFormat.yMd(locale.toString()).format(date);

/// カレンダーの月見出し・年部分
String formatMonthHeaderYear(DateTime month, Locale locale) =>
    DateFormat.y(locale.toString()).format(month);

/// カレンダーの月見出し・月部分
String formatMonthHeaderMonth(DateTime month, Locale locale) =>
    DateFormat.MMMM(locale.toString()).format(month);

/// リスト表示の月グループラベル（例: "Jul 2026" / "2026年7月" / "2026년 7월"）
String formatMonthGroupLabel(DateTime month, Locale locale) =>
    DateFormat.yMMM(locale.toString()).format(month);
