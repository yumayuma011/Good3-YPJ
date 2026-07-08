/// 1日分の「いいこと」記録データモデル
class GoodThingEntry {
  /// 日付（時刻情報は 0:00:00 に正規化して保持する）
  final DateTime date;

  /// 「いいこと」を最大3つまで格納する（空文字を含む場合あり）
  final List<String> items;

  GoodThingEntry({
    required this.date,
    required List<String> items,
  }) : items = _normalizeItems(items);

  static List<String> _normalizeItems(List<String> items) {
    final result = List<String>.from(items);
    while (result.length < 3) {
      result.add('');
    }
    return result.take(3).toList();
  }

  /// 日付だけを比較用キーにする（yyyyMMdd の整数）
  int get dateKey => date.year * 10000 + date.month * 100 + date.day;

  /// 入力が全て空欄かどうか
  bool get isEmptyRecord => items.every((e) => e.trim().isEmpty);

  /// 画面表示用（空欄を除いたリスト）
  List<String> get displayItems =>
      items.where((e) => e.trim().isNotEmpty).toList();

  GoodThingEntry copyWith({DateTime? date, List<String>? items}) {
    return GoodThingEntry(
      date: date ?? this.date,
      items: items ?? this.items,
    );
  }

  Map<String, dynamic> toJson() => {
        'date': DateTime(date.year, date.month, date.day).toIso8601String(),
        'items': items,
      };

  factory GoodThingEntry.fromJson(Map<String, dynamic> json) {
    return GoodThingEntry(
      date: DateTime.parse(json['date'] as String),
      items: (json['items'] as List<dynamic>).map((e) => e.toString()).toList(),
    );
  }

  static DateTime normalizeDate(DateTime d) => DateTime(d.year, d.month, d.day);
}
