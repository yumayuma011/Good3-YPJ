import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/good_thing_entry.dart';
import '../providers/entries_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_rules.dart';
import '../constants/app_strings.dart';
import '../constants/app_text_styles.dart';
import '../utils/weighted_length_formatter.dart';
import '../widgets/entry_detail_card.dart';

/// 「今日の記録」入力画面。日付＋3つのいいことを入力して保存する。
class RecordScreen extends StatefulWidget {
  const RecordScreen({super.key});

  @override
  State<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends State<RecordScreen> {
  DateTime _selectedDate = GoodThingEntry.normalizeDate(DateTime.now());
  final List<TextEditingController> _controllers =
      List.generate(3, (_) => TextEditingController());

  bool _showSavedBanner = false;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _pickDate() async {
    final today = GoodThingEntry.normalizeDate(DateTime.now());
    final picked = await showDatePicker(
      context: context,
      initialDate:
          _selectedDate.isAfter(today) ? today : _selectedDate,
      firstDate: DateTime(2000),
      lastDate: today, // 未来の日付は選択できないようにする
      helpText: AppStrings.datePickHelp,
      cancelText: AppStrings.cancel,
      confirmText: AppStrings.ok,
      fieldLabelText: AppStrings.dateFieldLabel,
      fieldHintText: AppStrings.dateFieldHint,
      errorFormatText: AppStrings.dateErrorFormat,
      errorInvalidText: AppStrings.dateErrorInvalid,
    );
    if (picked != null) {
      setState(() => _selectedDate = GoodThingEntry.normalizeDate(picked));
      _loadExistingEntryIntoFields();
    }
  }

  void _loadExistingEntryIntoFields() {
    final entry = context.read<EntriesProvider>().entryForDate(_selectedDate);
    for (var i = 0; i < 3; i++) {
      _controllers[i].text = entry != null ? entry.items[i] : '';
    }
  }

  Future<void> _save() async {
    final items = _controllers.map((c) => c.text).toList();
    await context.read<EntriesProvider>().upsertEntry(_selectedDate, items);

    setState(() => _showSavedBanner = true);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _showSavedBanner = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final entries = context.watch<EntriesProvider>().entriesDesc;
    final primary = Theme.of(context).colorScheme.primary;

    return Stack(
      children: [
        ListView(
          padding: const EdgeInsets.fromLTRB(
            AppDimens.paddingL,
            AppDimens.paddingM,
            AppDimens.paddingL,
            AppDimens.paddingXXL,
          ),
          children: [
            Container(
              padding: const EdgeInsets.all(AppDimens.paddingL),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(AppDimens.radiusXXL),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    AppStrings.recordCardTitle,
                    style: AppTextStyles.cardTitle,
                  ),
                  const SizedBox(height: 14),
                  const Text(AppStrings.recordDateLabel,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textSecondary,
                      )),
                  const SizedBox(height: 6),
                  InkWell(
                    onTap: _pickDate,
                    borderRadius: BorderRadius.circular(AppDimens.radiusM),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      decoration: BoxDecoration(
                        color: AppColors.rowBackground,
                        borderRadius:
                            BorderRadius.circular(AppDimens.radiusM),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatDateForField(_selectedDate),
                            style: AppTextStyles.fieldValue,
                          ),
                          const Icon(Icons.calendar_today_outlined,
                              size: AppDimens.iconM,
                              color: AppColors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    AppStrings.recordPrompt,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  for (var i = 0; i < 3; i++)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Container(
                              width: AppDimens.numberBadgeSizeLarge,
                              height: AppDimens.numberBadgeSizeLarge,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primary,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                '${i + 1}',
                                style: AppTextStyles.numberBadge,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: AnimatedBuilder(
                              animation: _controllers[i],
                              builder: (context, _) {
                                final weight =
                                    WeightedLengthLimitFormatter.weightOfText(
                                        _controllers[i].text);
                                return Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.end,
                                  children: [
                                    TextField(
                                      controller: _controllers[i],
                                      inputFormatters: [
                                        WeightedLengthLimitFormatter(
                                            AppRules.itemMaxWeight),
                                      ],
                                      decoration: InputDecoration(
                                        hintText: AppStrings.itemHint(i + 1),
                                        hintStyle: const TextStyle(
                                            color: AppColors.textSecondary),
                                        filled: true,
                                        fillColor: AppColors.rowBackground,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 14, vertical: 12),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              AppDimens.radiusM),
                                          borderSide: BorderSide.none,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 2, right: 4),
                                      child: Text(
                                        '${weight.toStringAsFixed(weight % 1 == 0 ? 0 : 1)} / ${AppRules.itemMaxWeight.toStringAsFixed(0)}',
                                        style: AppTextStyles.caption
                                            .copyWith(fontSize: 11),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: AppDimens.buttonHeight,
                    child: ElevatedButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save_outlined,
                          size: AppDimens.iconM),
                      label: const Text(AppStrings.recordSave),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppDimens.radiusM),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              AppStrings.recordListTitle,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: AppColors.textPrimary),
            ),
            const SizedBox(height: 10),
            if (entries.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 32),
                child: Center(
                  child: Text(
                    AppStrings.recordEmpty,
                    style: AppTextStyles.emptyState,
                  ),
                ),
              )
            else
              for (final entry in entries) EntryDetailCard(entry: entry),
          ],
        ),
        // 保存完了バナー
        if (_showSavedBanner)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.recordSavedBanner,
                    style: AppTextStyles.bannerText,
                  ),
                  SizedBox(width: 6),
                  Icon(Icons.check, color: Colors.white, size: AppDimens.iconS),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
