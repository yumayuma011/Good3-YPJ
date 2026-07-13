import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_color_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';

/// 設定 > カスタマイズ > カラー変更 画面。
///
/// あらかじめ用意した16色（暗め8色・明るめ8色）のプリセットから
/// テーマカラー（アクセントカラー）を選ぶだけのシンプルな画面。
///
/// ▼ プリセットの色を増やしたい/変えたい場合
///   → lib/constants/app_colors.dart の `presetColors` リストを編集するだけでOK。
///     このファイル（color_picker_screen.dart）は手を加える必要はない。
class ColorPickerScreen extends StatelessWidget {
  const ColorPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentColor = context.watch<ThemeColorProvider>().primaryColor;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(AppStrings.colorPickerTitle,
            style: TextStyle(color: AppColors.textPrimary)),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        children: [
          const Text('お好みの色を選んでください', style: AppTextStyles.sectionLabel),
          const SizedBox(height: AppDimens.paddingL),
          _PresetColorGrid(currentColor: currentColor),
        ],
      ),
    );
  }
}

/// 16色のプリセットカラーを丸いスウォッチで並べるグリッド。
/// 色の追加・削除は app_colors.dart の presetColors を編集するだけで反映される。
class _PresetColorGrid extends StatelessWidget {
  final Color currentColor;
  const _PresetColorGrid({required this.currentColor});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      mainAxisSpacing: AppDimens.paddingXL,
      crossAxisSpacing: AppDimens.paddingXL,
      children: AppColors.presetColors.map((color) {
        final isSelected = color.value == currentColor.value;
        return GestureDetector(
          onTap: () => context.read<ThemeColorProvider>().setColor(color),
          child: Container(
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: isSelected
                  ? Border.all(color: AppColors.textPrimary, width: 3)
                  : null,
            ),
            child: isSelected
                ? const Icon(Icons.check, color: Colors.white)
                : null,
          ),
        );
      }).toList(),
    );
  }
}
