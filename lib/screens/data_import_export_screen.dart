import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import '../providers/entries_provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimens.dart';
import '../constants/app_text_styles.dart';
import '../l10n/l10n_extensions.dart';

enum DataIOMode { import, export }

/// 設定 > データ > インポート / エクスポート 画面。
/// エクスポート: 記録データをJSONファイルとして書き出し、共有シートで送る。
/// インポート: JSONファイルを選択して読み込み、既存データを置き換える。
class DataImportExportScreen extends StatefulWidget {
  final DataIOMode mode;
  const DataImportExportScreen({super.key, required this.mode});

  @override
  State<DataImportExportScreen> createState() =>
      _DataImportExportScreenState();
}

class _DataImportExportScreenState extends State<DataImportExportScreen> {
  bool _isProcessing = false;
  String? _message;

  bool get _isExport => widget.mode == DataIOMode.export;

  Future<void> _handleExport() async {
    final l10n = context.l10n;
    setState(() => _isProcessing = true);
    try {
      final jsonStr = await context.read<EntriesProvider>().exportAsJson();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/kyou_no_iikoto_export.json');
      await file.writeAsString(jsonStr);
      await Share.shareXFiles([XFile(file.path)],
          text: '${l10n.appTitle} - ${l10n.exportTitle}');
      setState(() => _message = l10n.exportSuccessMsg);
    } catch (e) {
      setState(() => _message = l10n.exportErrorMsg(e.toString()));
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _handleImport() async {
    final l10n = context.l10n;
    setState(() => _isProcessing = true);
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );
      if (result == null || result.files.single.path == null) {
        setState(() => _isProcessing = false);
        return;
      }
      final file = File(result.files.single.path!);
      final content = await file.readAsString();
      await context.read<EntriesProvider>().importFromJson(content);
      setState(() => _message = l10n.importSuccessMsg);
    } catch (e) {
      setState(() => _message = l10n.importErrorMsg(e.toString()));
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(_isExport ? l10n.exportTitle : l10n.importTitle,
            style: const TextStyle(color: AppColors.textPrimary)),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppDimens.paddingXL),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _isExport ? l10n.exportDesc : l10n.importDesc,
              style: AppTextStyles.bodyText,
            ),
            const SizedBox(height: AppDimens.paddingXXL),
            SizedBox(
              width: double.infinity,
              height: AppDimens.buttonHeight,
              child: ElevatedButton(
                onPressed: _isProcessing
                    ? null
                    : (_isExport ? _handleExport : _handleImport),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppDimens.radiusM)),
                ),
                child: _isProcessing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                            strokeWidth: 2, color: Colors.white),
                      )
                    : Text(_isExport ? l10n.exportButton : l10n.importButton),
              ),
            ),
            if (_message != null) ...[
              const SizedBox(height: AppDimens.paddingL),
              Text(_message!,
                  style: const TextStyle(color: AppColors.textPrimary)),
            ],
          ],
        ),
      ),
    );
  }
}
