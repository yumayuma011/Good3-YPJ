import 'package:flutter/material.dart';
import 'app_colors.dart';

/// 画面間で繰り返し使う TextStyle を一元管理する。
/// フォントサイズやウェイトを変えたいときはここだけ直せば全画面に反映される。
class AppTextStyles {
  AppTextStyles._();

  // 画面タイトル（AppBar）
  static const appBarTitle = TextStyle(
    color: AppColors.textPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  // カードの見出し（例：「今日の記録」）
  static const cardTitle = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.textPrimary,
  );

  // セクション見出し（例：「カスタマイズ」）
  static const sectionLabel = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );

  // 入力フィールドの上に付くラベル（例：「日付」）
  static const fieldLabel = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );

  // 入力済みの値のテキスト
  static const fieldValue = TextStyle(
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  // 説明文・プロンプト（例：「今日あった…」）
  static const prompt = TextStyle(
    fontSize: 13,
    color: AppColors.textSecondary,
  );

  // 設定行のラベル
  static const rowLabel = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  // 記録カードの日付見出し（例：「2026 6.11 木」）
  static const entryDate = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
    color: AppColors.textPrimary,
  );

  // 記録カードの各項目テキスト
  static const entryItem = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  // 空状態のテキスト（例：「まだ記録がありません」）
  static const emptyState = TextStyle(
    color: AppColors.textSecondary,
  );

  // 保存完了バナーのテキスト
  static const bannerText = TextStyle(
    color: Colors.white,
    fontSize: 14,
  );

  // 番号バッジの数字
  static const numberBadge = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );

  static const numberBadgeSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.bold,
    color: AppColors.textSecondary,
  );

  // カレンダーのリスト表示：月のピル
  static const monthPill = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 13,
  );

  // 見出し（本文の大きめタイトル）
  static const screenHeading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  // 本文説明文
  static const bodyText = TextStyle(
    fontSize: 14,
    height: 1.6,
    color: AppColors.textSecondary,
  );

  // フッターのバージョン表記など
  static const caption = TextStyle(
    color: AppColors.textSecondary,
    fontSize: 12,
  );
}
