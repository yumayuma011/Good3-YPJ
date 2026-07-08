import 'package:flutter/services.dart';

/// 半角英数字は「0.5文字分」、それ以外（日本語・記号など）は「1文字分」として
/// カウントし、合計が maxWeight を超えないように入力を制限する Formatter。
///
/// 例）maxWeight = 50 の場合
///   ・全角(日本語)のみ  → 最大 50文字
///   ・半角英数字のみ    → 最大 100文字
///   ・混在              → 半角英数字は0.5文字分としてカウントされる
class WeightedLengthLimitFormatter extends TextInputFormatter {
  final double maxWeight;

  WeightedLengthLimitFormatter(this.maxWeight);

  static final _halfWidthAlnum = RegExp(r'^[a-zA-Z0-9]$');

  /// 1文字あたりの重みを返す
  static double weightOfChar(String char) {
    return _halfWidthAlnum.hasMatch(char) ? 0.5 : 1.0;
  }

  /// 文字列全体の重み（＝実質の文字数カウント）を計算する
  static double weightOfText(String text) {
    var weight = 0.0;
    for (final rune in text.runes) {
      weight += weightOfChar(String.fromCharCode(rune));
    }
    return weight;
  }

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    var weight = 0.0;
    final buffer = StringBuffer();
    var runeCount = 0;

    for (final rune in newValue.text.runes) {
      final char = String.fromCharCode(rune);
      final w = weightOfChar(char);
      if (weight + w > maxWeight) break;
      weight += w;
      buffer.write(char);
      runeCount++;
    }

    final newText = buffer.toString();
    if (newText == newValue.text) {
      return newValue;
    }

    // 超過分を切り捨てた場合はカーソルを末尾に合わせる
    final newOffset = runeCount;
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newOffset),
    );
  }
}
