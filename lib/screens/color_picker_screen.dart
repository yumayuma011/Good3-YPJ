import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_color_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_strings.dart';

/// 設定 > カスタマイズ > カラー変更 画面。
/// テーマカラー（アクセントカラー）をプリセットから選択する。
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
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: AppDimens.paddingXL,
          crossAxisSpacing: AppDimens.paddingXL,
          children: AppColors.presetColors.map((color) {
            final isSelected = color.value == currentColor.value;
            return GestureDetector(
              onTap: () =>
                  context.read<ThemeColorProvider>().setColor(color),
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
        ),
      ),
    );
  }
}
