/// アプリ内で表示するすべての文言をここにまとめる。
/// 表記ゆれを防ぎ、多言語化する際もこのファイルだけ差し替えれば良いようにする。
class AppStrings {
  AppStrings._();

  // ---------------- 共通 ----------------
  static const appTitle = '今日のいいこと';
  static const ok = 'OK';
  static const cancel = 'キャンセル';

  // ---------------- 下部ナビゲーション ----------------
  static const navRecord = '記録';
  static const navCalendar = 'カレンダー';

  // ---------------- 通知許可画面 ----------------
  static const notifPermissionTitle = 'デイリー通知を設定しましょう';
  static const notifPermissionBody =
      '毎日決まった時間に「今日のいいこと」を\n記録するお知らせを届けます。\n通知は設定画面からいつでも変更できます。';
  static const notifPermissionAllow = '通知を許可する';
  static const notifPermissionSkip = 'あとで設定する';

  // ---------------- 記録画面 ----------------
  static const recordCardTitle = '今日の記録';
  static const recordDateLabel = '日付';
  // static const recordPrompt = '今日あった「いいこと」を思いつく範囲で書いてみましょう';
  static const recordPrompt = '今日あった「いいこと」を3つ書いてみましょう\nどんなに小さなことでも構いません\n思いつかない日があっても大丈夫 そのまま保存してみましょう';
  static const recordSave = '保存する';
  static const recordSavedBanner = '保存しました';
  static const recordListTitle = 'ｄ記録内容';
  static const recordEmpty = 'まだ記録がありません';
  static const defaultFallbackItem = '今日も生きていた';
  static String itemHint(int number) => 'いいこと$number';

  // 日付選択ダイアログ
  static const datePickHelp = '日付を選択';
  static const dateFieldLabel = '日付を入力';
  static const dateFieldHint = 'yyyy/mm/dd';
  static const dateErrorFormat = '正しい形式で入力してください';
  static const dateErrorInvalid = '有効な日付を入力してください';

  // ---------------- カレンダー画面 ----------------
  static const calendarNoEntry = 'この日の記録はまだありません';
  static const weekdayHeaders = ['日', '月', '火', '水', '木', '金', '土'];
  static const weekdaysMonFirst = ['月', '火', '水', '木', '金', '土', '日'];

  // ---------------- 設定画面 ----------------
  static const settingsCustomizeSection = 'カスタマイズ';
  static const settingsColorChange = 'カラー変更';
  static const settingsDailyNotification = 'デイリー通知設定';
  static const settingsDataSection = 'データ';
  static const settingsImport = 'データのインポート';
  static const settingsExport = 'データのエクスポート';
  static const settingsSupportSection = 'サポート';
  static const settingsSupport = 'サポート';
  static const settingsManageDataSection = 'データを管理';
  static const settingsResetAll = 'すべてのデータをリセット';
  static const settingsRecommendedApps = 'おすすめのアプリ';
  static const settingsVersionPrefix = 'ⓘ Version ';

  static const resetConfirmTitle = 'すべてのデータをリセット';
  static const resetConfirmBody =
      '記録した内容はすべて削除されます。この操作は取り消せません。よろしいですか？';
  static const resetConfirmDelete = '削除する';
  static const resetDoneSnackbar = 'すべてのデータを削除しました';

  // ---------------- サポート画面 ----------------
  static const supportContact = 'お問い合わせ';
  static const supportFaq = 'よくある質問';
  static const supportTerms = '利用規約';
  static const supportPrivacy = 'プライバシーポリシー';
  static const supportLegal = '特定商取引法に基づく表記';
  static const supportOssLicense = 'オープンソースライセンス';

  static const contactEmail = 'support@example.com';
  static const contactSubject = '【今日のいいこと】お問い合わせ';

  static const faqBody = 'ここによくある質問と回答を記載してください。\n\n'
      'Q. 記録は何件まで保存できますか？\nA. 端末の容量が許す限り保存できます。\n\n'
      'Q. データはどこに保存されますか？\nA. 端末内にのみ保存され、外部には送信されません。';
  static const termsBody = 'ここに利用規約の本文を記載してください。';
  static const privacyBody = 'ここにプライバシーポリシーの本文を記載してください。';
  static const legalBody = 'ここに特定商取引法に基づく表記の内容を記載してください。';

  // ---------------- カラー変更画面 ----------------
  static const colorPickerTitle = 'カラー変更';

  // ---------------- デイリー通知設定画面 ----------------
  static const notifSettingTitle = 'デイリー通知設定';
  static const notifEnableLabel = '通知を有効にする';
  static const notifTimeLabelPrefix = '通知時刻：';
  static const pickTimeHelp = '通知時刻を選択';

  // ---------------- データ インポート/エクスポート画面 ----------------
  static const exportTitle = 'データのエクスポート';
  static const importTitle = 'データのインポート';
  static const exportDesc =
      '記録したデータをJSONファイルとして書き出します。\nバックアップや機種変更の際にご利用ください。';
  static const importDesc =
      '以前エクスポートしたJSONファイルを選択して読み込みます。\n※現在のデータは上書きされます。';
  static const exportButton = 'エクスポートする';
  static const importButton = 'ファイルを選択する';
  static const exportSuccessMsg = 'エクスポートが完了しました';
  static const importSuccessMsg = 'インポートが完了しました';
  static String exportErrorMsg(Object e) => 'エクスポートに失敗しました: $e';
  static String importErrorMsg(Object e) => 'インポートに失敗しました: $e';
}
