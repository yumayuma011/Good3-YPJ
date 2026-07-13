import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_rules.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../utils/weighted_length_formatter.dart';

/// 「いいこと」1件を入力するためのポップアップ（ダイアログ）。
///
/// 記録画面のメイン枠はタップ用の「表示エリア」に留め、
/// 実際の文字入力はこのポップアップの中で行う。
/// 文字数カウンター（0/50）は、入力欄と同じ枠の中・右下に配置している。
///
/// 呼び出し側は [showGoodThingInputDialog] を使う。
Future<String?> showGoodThingInputDialog({
  required BuildContext context,
  required int number,
  required String initialText,
}) {
  return showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder: (context) => _GoodThingInputDialog(
      number: number,
      initialText: initialText,
    ),
  );
}

class _GoodThingInputDialog extends StatefulWidget {
  final int number;
  final String initialText;

  const _GoodThingInputDialog({
    required this.number,
    required this.initialText,
  });

  @override
  State<_GoodThingInputDialog> createState() => _GoodThingInputDialogState();
}

class _GoodThingInputDialogState extends State<_GoodThingInputDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    Navigator.of(context).pop(_controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).colorScheme.primary;

    return Dialog(
      backgroundColor: AppColors.cardBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: AppDimens.numberBadgeSizeLarge,
                  height: AppDimens.numberBadgeSizeLarge,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: primary,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${widget.number}',
                    style: AppTextStyles.numberBadge,
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  AppStrings.itemHint(widget.number),
                  style: AppTextStyles.cardTitle,
                ),
              ],
            ),
            const SizedBox(height: AppDimens.paddingL),
            // 入力欄と文字数カウンターを同じ枠の中にまとめる
            AnimatedBuilder(
              animation: _controller,
              builder: (context, _) {
                final weight =
                    WeightedLengthLimitFormatter.weightOfText(_controller.text);
                return Container(
                  padding: const EdgeInsets.fromLTRB(14, 10, 14, 4),
                  decoration: BoxDecoration(
                    color: AppColors.rowBackground,
                    borderRadius: BorderRadius.circular(AppDimens.radiusM),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _controller,
                        autofocus: true,
                        minLines: 3,
                        maxLines: 6,
                        inputFormatters: [
                          WeightedLengthLimitFormatter(AppRules.itemMaxWeight),
                        ],
                        decoration: InputDecoration(
                          hintText: AppStrings.itemHint(widget.number),
                          hintStyle:
                              const TextStyle(color: AppColors.textSecondary),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                        ),
                      ),
                      Align(
                        // 文字数カウンターは枠内・右寄せに配置
                        alignment: Alignment.centerRight,
                        child: Text(
                          '${weight.toStringAsFixed(weight % 1 == 0 ? 0 : 1)} / ${AppRules.itemMaxWeight.toStringAsFixed(0)}',
                          style: AppTextStyles.caption.copyWith(fontSize: 11),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: AppDimens.paddingL),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(AppStrings.cancel),
                  ),
                ),
                const SizedBox(width: AppDimens.paddingM),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppDimens.radiusM),
                      ),
                    ),
                    child: const Text(AppStrings.ok),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
