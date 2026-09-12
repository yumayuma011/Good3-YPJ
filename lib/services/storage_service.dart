import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/good_thing_entry.dart';

/// SharedPreferences を使ったローカルデータ永続化サービス。
/// 将来 sqflite / Hive 等に差し替える場合もこのクラスのAPIだけ守れば良い。
class StorageService {
  static const _keyEntries = 'entries_v1';
  static const _keyThemeColor = 'theme_color_v1';
  static const _keyNotifEnabled = 'notif_enabled_v1';
  static const _keyNotifTime = 'notif_time_v1'; // "HH:mm"
  static const _keyNotifPermissionAsked = 'notif_permission_asked_v1';

  // ---------------- 記録データ ----------------

  Future<List<GoodThingEntry>> loadEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_keyEntries);
    if (raw == null || raw.isEmpty) return [];
    final list = jsonDecode(raw) as List<dynamic>;
    return list
        .map((e) => GoodThingEntry.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> saveEntries(List<GoodThingEntry> entries) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(entries.map((e) => e.toJson()).toList());
    await prefs.setString(_keyEntries, raw);
  }

  /// エクスポート用のJSON文字列を返す
  Future<String> exportEntriesAsJson() async {
    final entries = await loadEntries();
    return const JsonEncoder.withIndent('  ')
        .convert(entries.map((e) => e.toJson()).toList());
  }

  /// JSON文字列からインポートする（既存データは上書きされる）
  Future<List<GoodThingEntry>> importEntriesFromJson(String jsonStr) async {
    final list = jsonDecode(jsonStr) as List<dynamic>;
    final entries = list
        .map((e) => GoodThingEntry.fromJson(e as Map<String, dynamic>))
        .toList();
    await saveEntries(entries);
    return entries;
  }

  Future<void> resetAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_keyEntries);
  }

  // ---------------- テーマカラー ----------------

  Future<Color?> loadThemeColor() async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getInt(_keyThemeColor);
    if (value == null) return null;
    return Color(value);
  }

  Future<void> saveThemeColor(Color color) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyThemeColor, color.value);
  }

  // ---------------- 通知設定 ----------------

  Future<bool> loadNotifEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotifEnabled) ?? false;
  }

  Future<void> saveNotifEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotifEnabled, enabled);
  }

  /// "HH:mm" 形式で保存
  Future<String> loadNotifTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyNotifTime) ?? '21:00';
  }

  Future<void> saveNotifTime(String hhmm) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyNotifTime, hhmm);
  }

  Future<bool> loadNotifPermissionAsked() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyNotifPermissionAsked) ?? false;
  }

  Future<void> saveNotifPermissionAsked(bool asked) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyNotifPermissionAsked, asked);
  }
}
