import 'package:flutter/material.dart';

/// アプリ全体の配色。設定画面の「カラー変更」で primary のみ差し替え可能。
class AppColors {
  AppColors._();

  /// ユーザーが選択できるテーマカラーの候補一覧（暗め8色 + 明るめ8色 = 16色）
  static const List<Color> presetColors = [
    // ── 暗め（8色） ──
    Color(0xFF4E3B2A), // ブラウン（デフォルト）
    Color(0xFF3D2E22), // ダークブラウン
    Color(0xFF8B2E2E), // ダークレッド
    Color(0xFF7A4A1F), // ダークオレンジ
    Color(0xFF5C5220), // ダークイエロー（オリーブ）
    Color(0xFF2E5233), // ダークグリーン
    Color(0xFF1F4E4A), // ダークティール
    Color(0xFF2E3F5C), // ダークブルー

    // ── 明るめ（8色） ──
    Color(0xFFD98880), // ライトレッド
    Color(0xFFE8A96B), // ライトオレンジ
    Color(0xFFE0C868), // ライトイエロー
    Color(0xFF8FC28F), // ライトグリーン
    Color(0xFF7FC9C4), // ライトティール
    Color(0xFF8FB4E0), // ライトブルー
    Color(0xFFB59BD9), // ライトパープル
    Color(0xFFE39FC2), // ライトピンク
  ];

  static const Color defaultPrimary = Color(0xFF4E3B2A);
  static const Color background = Color(0xFFF4F1EA);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color rowBackground = Color(0xFFEFE7D8);
  static const Color textPrimary = Color(0xFF3D2E22);
  static const Color textSecondary = Color(0xFF9A8F7D);
  static const Color divider = Color(0xFFE4DCC9);

 /// 月ごとのラベル色（インデックス0=1月, 1=2月, ... 11=12月に対応）
  static const List<Color> monthPillColors = [
    Color(0xFFE60033), // 赤 (1月)
    Color(0xFF884798), // 紫 (2月)
    Color(0xFF2C8593), // 水色 (3月)
    Color(0xFFDCAE63), // 花舞小枝 はなまいこえだ (4月)
    Color(0xFF662E51), // 初恋薊 はつこいあざみ (5月)
    Color(0xFF557F65), // 憧葛 あこがれかずら (6月)
    Color(0xFFF09199), // 桃色 (7月)
    Color(0xFFB8D200), // 黄緑 (8月)
    Color(0xFF0095D9), // 青 (9月)
    Color(0xFFEE7800), // 橙色 (10月)
    Color(0xFFFFD900), // 黄色 (11月)
    Color(0xFFC4B5A6), // 勿忘菫 わすれなすみれ (12月)
  ];
}