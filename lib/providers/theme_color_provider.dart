import 'package:flutter/material.dart';
import '../services/storage_service.dart';
import '../constants/app_colors.dart';

/// ユーザーが選んだテーマカラー（アクセントカラー）を保持するProvider。
class ThemeColorProvider extends ChangeNotifier {
  final StorageService _storage;
  Color _primaryColor = AppColors.defaultPrimary;

  ThemeColorProvider(this._storage);

  Color get primaryColor => _primaryColor;

  Future<void> load() async {
    final saved = await _storage.loadThemeColor();
    if (saved != null) {
      _primaryColor = saved;
      notifyListeners();
    }
  }

  Future<void> setColor(Color color) async {
    _primaryColor = color;
    await _storage.saveThemeColor(color);
    notifyListeners();
  }
}
