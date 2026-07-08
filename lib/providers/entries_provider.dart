import 'package:flutter/foundation.dart';
import '../constants/app_strings.dart';
import '../models/good_thing_entry.dart';
import '../services/storage_service.dart';

/// 「いいこと」記録の一覧を保持し、画面から参照・更新するためのProvider。
class EntriesProvider extends ChangeNotifier {
  final StorageService _storage;
  List<GoodThingEntry> _entries = [];
  bool _loaded = false;

  EntriesProvider(this._storage);

  bool get isLoaded => _loaded;

  /// 日付の新しい順（記録画面のリスト用）
  List<GoodThingEntry> get entriesDesc {
    final list = List<GoodThingEntry>.from(_entries);
    list.sort((a, b) => b.date.compareTo(a.date));
    return list;
  }

  /// 日付の古い順（カレンダー画面のリスト表示用）
  List<GoodThingEntry> get entriesAsc {
    final list = List<GoodThingEntry>.from(_entries);
    list.sort((a, b) => a.date.compareTo(b.date));
    return list;
  }

  Future<void> load() async {
    _entries = await _storage.loadEntries();
    _loaded = true;
    notifyListeners();
  }

  GoodThingEntry? entryForDate(DateTime date) {
    final key = GoodThingEntry.normalizeDate(date);
    for (final e in _entries) {
      if (e.date.year == key.year &&
          e.date.month == key.month &&
          e.date.day == key.day) {
        return e;
      }
    }
    return null;
  }

  /// 同じ日付の記録があれば上書き、なければ新規追加する
  Future<void> upsertEntry(DateTime date, List<String> items) async {
    final normalizedDate = GoodThingEntry.normalizeDate(date);
    var finalItems = items;
    // 3つとも空欄で保存された場合はデフォルトの一言を入れる
    if (items.every((e) => e.trim().isEmpty)) {
      finalItems = [AppStrings.defaultFallbackItem, '', ''];
    }
    final newEntry = GoodThingEntry(date: normalizedDate, items: finalItems);

    final idx = _entries.indexWhere((e) =>
        e.date.year == normalizedDate.year &&
        e.date.month == normalizedDate.month &&
        e.date.day == normalizedDate.day);

    if (idx >= 0) {
      _entries[idx] = newEntry;
    } else {
      _entries.add(newEntry);
    }
    await _storage.saveEntries(_entries);
    notifyListeners();
  }

  Set<DateTime> get datesWithEntries =>
      _entries.map((e) => GoodThingEntry.normalizeDate(e.date)).toSet();

  Future<void> resetAll() async {
    _entries = [];
    await _storage.resetAllData();
    notifyListeners();
  }

  Future<String> exportAsJson() => _storage.exportEntriesAsJson();

  Future<void> importFromJson(String jsonStr) async {
    _entries = await _storage.importEntriesFromJson(jsonStr);
    notifyListeners();
  }
}
