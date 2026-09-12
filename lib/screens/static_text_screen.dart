import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';

/// FAQ・利用規約・プライバシーポリシー・特商法表記など、
/// 静的な本文を表示するだけの汎用画面。
class StaticTextScreen extends StatelessWidget {
  final String title;
  final String body;

  const StaticTextScreen({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(title,
            style: const TextStyle(color: AppColors.textPrimary)),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Text(
          body,
          style: const TextStyle(
              fontSize: 14, height: 1.7, color: AppColors.textPrimary),
        ),
      ),
    );
  }
}
