import 'package:flutter/material.dart';

/// アプリ全体の配色。設定画面の「カラー変更」で primary のみ差し替え可能。
class AppColors {
  AppColors._();

  /// ユーザーが選択できるテーマカラーの候補一覧
  static const List<Color> presetColors = [
    Color(0xFF4E3B2A), // ブラウン（デフォルト）
    Color(0xFFB0473A), // レッド
    Color(0xFFC97A3D), // オレンジ
    Color(0xFFB79A2E), // イエロー
    Color(0xFF4E7A52), // グリーン
    Color(0xFF2E8F8A), // ティール
    Color(0xFF3E6FA8), // ブルー
    Color(0xFF7A5AA8), // パープル
    Color(0xFFC06090), // ピンク
  ];

  static const Color defaultPrimary = Color(0xFF4E3B2A);

  static const Color background = Color(0xFFF4F1EA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color rowBackground = Color(0xFFEFE7D8);
  static const Color textPrimary = Color(0xFF3D2E22);
  static const Color textSecondary = Color(0xFF9A8F7D);
  static const Color divider = Color(0xFFE4DCC9);

  /// 月ごとのラベルに使う淡色パレット（画像の月別リストのピル表示用）
  static const List<Color> monthPillColors = [
    Color(0xFFE60033), // 赤(1月)
    Color(0xFF884798), // 紫(2月)
    Color(0xFFBCE2E8), // 水色(3月)
    Color(0xFFDCAE63), // 花舞小(4月)
    Color(0xFF3EB370), // 緑(5月)
    Color(0xFF7D7D7D), // 灰色(6月)
    Color(0xFFB8D200), // 桃色(7月)
    Color(0xFFB8D200), // 黄緑(8月)
    Color(0xFF0095D9), // 青(9月)
    Color(0xFFEE7800), // 橙色(10月)
    Color(0xFFFFD900), // 黄色(11月)
    Color(0xFFCFC3B7), // 勿忘菫(12月)
  ];
}
