// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => '今日のいいこと';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'キャンセル';

  @override
  String get navRecord => '記録';

  @override
  String get navCalendar => 'カレンダー';

  @override
  String get notifPermissionTitle => 'デイリー通知を設定しましょう';

  @override
  String get notifPermissionBody =>
      '毎日決まった時間に「今日のいいこと」を\n記録するお知らせを届けます。\n通知は設定画面からいつでも変更できます。';

  @override
  String get notifPermissionAllow => '通知を許可する';

  @override
  String get notifPermissionSkip => 'あとで設定する';

  @override
  String get recordCardTitle => '今日の記録';

  @override
  String get recordDateLabel => '日付';

  @override
  String get recordPrompt => '今日あった「いいこと」を3つ書いてみましょう\nどんなに小さなことでも構いません';

  @override
  String get recordPrompt2 => '思いつかなくても大丈夫\nそのまま保存してみましょう';

  @override
  String get recordSave => '保存する';

  @override
  String get recordSavedBanner => '保存しました';

  @override
  String get recordListTitle => '記録内容';

  @override
  String get recordEmpty => 'まだ記録がありません';

  @override
  String get defaultFallbackItem => '今日も生きていた';

  @override
  String itemHint(int number) {
    return 'いいこと$number';
  }

  @override
  String get calendarNoEntry => 'この日の記録はまだありません';

  @override
  String get settingsCustomizeSection => 'カスタマイズ';

  @override
  String get settingsColorChange => 'カラー変更';

  @override
  String get settingsDailyNotification => 'デイリー通知設定';

  @override
  String get settingsDataSection => 'データ';

  @override
  String get settingsImport => 'データのインポート';

  @override
  String get settingsExport => 'データのエクスポート';

  @override
  String get settingsSupportSection => 'サポート';

  @override
  String get settingsSupport => 'サポート';

  @override
  String get settingsManageDataSection => 'データを管理';

  @override
  String get settingsResetAll => 'すべてのデータをリセット';

  @override
  String get settingsRecommendedApps => 'おすすめのアプリ';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get resetConfirmTitle => 'すべてのデータをリセット';

  @override
  String get resetConfirmBody => '記録した内容はすべて削除されます。この操作は取り消せません。よろしいですか？';

  @override
  String get resetConfirmDelete => '削除する';

  @override
  String get resetDoneSnackbar => 'すべてのデータを削除しました';

  @override
  String get supportContact => 'お問い合わせ';

  @override
  String get supportFaq => 'よくある質問';

  @override
  String get supportTerms => '利用規約';

  @override
  String get supportPrivacy => 'プライバシーポリシー';

  @override
  String get supportLegal => '特定商取引法に基づく表記';

  @override
  String get supportOssLicense => 'オープンソースライセンス';

  @override
  String get contactSubject => '【今日のいいこと】お問い合わせ';

  @override
  String get faqBody =>
      'ここによくある質問と回答を記載してください。\n\nQ. 記録は何件まで保存できますか？\nA. 端末の容量が許す限り保存できます。\n\nQ. データはどこに保存されますか？\nA. 端末内にのみ保存され、外部には送信されません。';

  @override
  String get termsBody => 'ここに利用規約の本文を記載してください。';

  @override
  String get privacyBody => 'ここにプライバシーポリシーの本文を記載してください。';

  @override
  String get legalBody => 'ここに特定商取引法に基づく表記の内容を記載してください。';

  @override
  String get colorPickerTitle => 'カラー変更';

  @override
  String get colorPickerPrompt => 'お好みの色を選んでください';

  @override
  String get notifSettingTitle => 'デイリー通知設定';

  @override
  String get notifEnableLabel => '通知を有効にする';

  @override
  String notifTimeLabel(String time) {
    return '通知時刻：$time';
  }

  @override
  String get exportTitle => 'データのエクスポート';

  @override
  String get importTitle => 'データのインポート';

  @override
  String get exportDesc => '記録したデータをJSONファイルとして書き出します。\nバックアップや機種変更の際にご利用ください。';

  @override
  String get importDesc => '以前出力したJSONファイルを選択して読込みます。\n※現在のデータは上書きされます。';

  @override
  String get exportButton => 'エクスポートする';

  @override
  String get importButton => 'ファイルを選択する';

  @override
  String get exportSuccessMsg => 'エクスポートが完了しました';

  @override
  String get importSuccessMsg => 'インポートが完了しました';

  @override
  String exportErrorMsg(String message) {
    return 'エクスポートに失敗しました: $message';
  }

  @override
  String importErrorMsg(String message) {
    return 'インポートに失敗しました: $message';
  }

  @override
  String get dailyNotificationChannelName => 'デイリー通知';

  @override
  String get dailyNotificationChannelDescription => '今日のいいことを記録する時間をお知らせします';

  @override
  String get dailyNotificationTitle => '今日のいいこと';

  @override
  String get dailyNotificationBody => '今日あった「いいこと」を記録しましょう☺️';
}
