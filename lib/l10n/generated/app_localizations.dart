import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('ko'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In ja, this message translates to:
  /// **'今日のいいこと'**
  String get appTitle;

  /// No description provided for @ok.
  ///
  /// In ja, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @cancel.
  ///
  /// In ja, this message translates to:
  /// **'キャンセル'**
  String get cancel;

  /// No description provided for @navRecord.
  ///
  /// In ja, this message translates to:
  /// **'記録'**
  String get navRecord;

  /// No description provided for @navCalendar.
  ///
  /// In ja, this message translates to:
  /// **'カレンダー'**
  String get navCalendar;

  /// No description provided for @notifPermissionTitle.
  ///
  /// In ja, this message translates to:
  /// **'デイリー通知を設定しましょう'**
  String get notifPermissionTitle;

  /// No description provided for @notifPermissionBody.
  ///
  /// In ja, this message translates to:
  /// **'毎日決まった時間に「今日のいいこと」を\n記録するお知らせを届けます。\n通知は設定画面からいつでも変更できます。'**
  String get notifPermissionBody;

  /// No description provided for @notifPermissionAllow.
  ///
  /// In ja, this message translates to:
  /// **'通知を許可する'**
  String get notifPermissionAllow;

  /// No description provided for @notifPermissionSkip.
  ///
  /// In ja, this message translates to:
  /// **'あとで設定する'**
  String get notifPermissionSkip;

  /// No description provided for @recordCardTitle.
  ///
  /// In ja, this message translates to:
  /// **'今日の記録'**
  String get recordCardTitle;

  /// No description provided for @recordDateLabel.
  ///
  /// In ja, this message translates to:
  /// **'日付'**
  String get recordDateLabel;

  /// No description provided for @recordPrompt.
  ///
  /// In ja, this message translates to:
  /// **'今日あった「いいこと」を3つ書いてみましょう\nどんなに小さなことでも構いません'**
  String get recordPrompt;

  /// No description provided for @recordPrompt2.
  ///
  /// In ja, this message translates to:
  /// **'思いつかなくても大丈夫\nそのまま保存してみましょう'**
  String get recordPrompt2;

  /// No description provided for @recordSave.
  ///
  /// In ja, this message translates to:
  /// **'保存する'**
  String get recordSave;

  /// No description provided for @recordSavedBanner.
  ///
  /// In ja, this message translates to:
  /// **'保存しました'**
  String get recordSavedBanner;

  /// No description provided for @recordListTitle.
  ///
  /// In ja, this message translates to:
  /// **'記録内容'**
  String get recordListTitle;

  /// No description provided for @recordEmpty.
  ///
  /// In ja, this message translates to:
  /// **'まだ記録がありません'**
  String get recordEmpty;

  /// No description provided for @defaultFallbackItem.
  ///
  /// In ja, this message translates to:
  /// **'今日も生きていた'**
  String get defaultFallbackItem;

  /// No description provided for @itemHint.
  ///
  /// In ja, this message translates to:
  /// **'いいこと{number}'**
  String itemHint(int number);

  /// No description provided for @calendarNoEntry.
  ///
  /// In ja, this message translates to:
  /// **'この日の記録はまだありません'**
  String get calendarNoEntry;

  /// No description provided for @settingsCustomizeSection.
  ///
  /// In ja, this message translates to:
  /// **'カスタマイズ'**
  String get settingsCustomizeSection;

  /// No description provided for @settingsColorChange.
  ///
  /// In ja, this message translates to:
  /// **'カラー変更'**
  String get settingsColorChange;

  /// No description provided for @settingsDailyNotification.
  ///
  /// In ja, this message translates to:
  /// **'デイリー通知設定'**
  String get settingsDailyNotification;

  /// No description provided for @settingsDataSection.
  ///
  /// In ja, this message translates to:
  /// **'データ'**
  String get settingsDataSection;

  /// No description provided for @settingsImport.
  ///
  /// In ja, this message translates to:
  /// **'データのインポート'**
  String get settingsImport;

  /// No description provided for @settingsExport.
  ///
  /// In ja, this message translates to:
  /// **'データのエクスポート'**
  String get settingsExport;

  /// No description provided for @settingsSupportSection.
  ///
  /// In ja, this message translates to:
  /// **'サポート'**
  String get settingsSupportSection;

  /// No description provided for @settingsSupport.
  ///
  /// In ja, this message translates to:
  /// **'サポート'**
  String get settingsSupport;

  /// No description provided for @settingsManageDataSection.
  ///
  /// In ja, this message translates to:
  /// **'データを管理'**
  String get settingsManageDataSection;

  /// No description provided for @settingsResetAll.
  ///
  /// In ja, this message translates to:
  /// **'すべてのデータをリセット'**
  String get settingsResetAll;

  /// No description provided for @settingsRecommendedApps.
  ///
  /// In ja, this message translates to:
  /// **'おすすめのアプリ'**
  String get settingsRecommendedApps;

  /// No description provided for @settingsVersion.
  ///
  /// In ja, this message translates to:
  /// **'Version {version}'**
  String settingsVersion(String version);

  /// No description provided for @resetConfirmTitle.
  ///
  /// In ja, this message translates to:
  /// **'すべてのデータをリセット'**
  String get resetConfirmTitle;

  /// No description provided for @resetConfirmBody.
  ///
  /// In ja, this message translates to:
  /// **'記録した内容はすべて削除されます。この操作は取り消せません。よろしいですか？'**
  String get resetConfirmBody;

  /// No description provided for @resetConfirmDelete.
  ///
  /// In ja, this message translates to:
  /// **'削除する'**
  String get resetConfirmDelete;

  /// No description provided for @resetDoneSnackbar.
  ///
  /// In ja, this message translates to:
  /// **'すべてのデータを削除しました'**
  String get resetDoneSnackbar;

  /// No description provided for @supportContact.
  ///
  /// In ja, this message translates to:
  /// **'お問い合わせ'**
  String get supportContact;

  /// No description provided for @supportFaq.
  ///
  /// In ja, this message translates to:
  /// **'よくある質問'**
  String get supportFaq;

  /// No description provided for @supportTerms.
  ///
  /// In ja, this message translates to:
  /// **'利用規約'**
  String get supportTerms;

  /// No description provided for @supportPrivacy.
  ///
  /// In ja, this message translates to:
  /// **'プライバシーポリシー'**
  String get supportPrivacy;

  /// No description provided for @supportLegal.
  ///
  /// In ja, this message translates to:
  /// **'特定商取引法に基づく表記'**
  String get supportLegal;

  /// No description provided for @supportOssLicense.
  ///
  /// In ja, this message translates to:
  /// **'オープンソースライセンス'**
  String get supportOssLicense;

  /// No description provided for @contactSubject.
  ///
  /// In ja, this message translates to:
  /// **'【今日のいいこと】お問い合わせ'**
  String get contactSubject;

  /// No description provided for @faqBody.
  ///
  /// In ja, this message translates to:
  /// **'ここによくある質問と回答を記載してください。\n\nQ. 記録は何件まで保存できますか？\nA. 端末の容量が許す限り保存できます。\n\nQ. データはどこに保存されますか？\nA. 端末内にのみ保存され、外部には送信されません。'**
  String get faqBody;

  /// No description provided for @termsBody.
  ///
  /// In ja, this message translates to:
  /// **'ここに利用規約の本文を記載してください。'**
  String get termsBody;

  /// No description provided for @privacyBody.
  ///
  /// In ja, this message translates to:
  /// **'ここにプライバシーポリシーの本文を記載してください。'**
  String get privacyBody;

  /// No description provided for @legalBody.
  ///
  /// In ja, this message translates to:
  /// **'ここに特定商取引法に基づく表記の内容を記載してください。'**
  String get legalBody;

  /// No description provided for @colorPickerTitle.
  ///
  /// In ja, this message translates to:
  /// **'カラー変更'**
  String get colorPickerTitle;

  /// No description provided for @colorPickerPrompt.
  ///
  /// In ja, this message translates to:
  /// **'お好みの色を選んでください'**
  String get colorPickerPrompt;

  /// No description provided for @notifSettingTitle.
  ///
  /// In ja, this message translates to:
  /// **'デイリー通知設定'**
  String get notifSettingTitle;

  /// No description provided for @notifEnableLabel.
  ///
  /// In ja, this message translates to:
  /// **'通知を有効にする'**
  String get notifEnableLabel;

  /// No description provided for @notifTimeLabel.
  ///
  /// In ja, this message translates to:
  /// **'通知時刻：{time}'**
  String notifTimeLabel(String time);

  /// No description provided for @exportTitle.
  ///
  /// In ja, this message translates to:
  /// **'データのエクスポート'**
  String get exportTitle;

  /// No description provided for @importTitle.
  ///
  /// In ja, this message translates to:
  /// **'データのインポート'**
  String get importTitle;

  /// No description provided for @exportDesc.
  ///
  /// In ja, this message translates to:
  /// **'記録したデータをJSONファイルとして書き出します。\nバックアップや機種変更の際にご利用ください。'**
  String get exportDesc;

  /// No description provided for @importDesc.
  ///
  /// In ja, this message translates to:
  /// **'以前出力したJSONファイルを選択して読込みます。\n※現在のデータは上書きされます。'**
  String get importDesc;

  /// No description provided for @exportButton.
  ///
  /// In ja, this message translates to:
  /// **'エクスポートする'**
  String get exportButton;

  /// No description provided for @importButton.
  ///
  /// In ja, this message translates to:
  /// **'ファイルを選択する'**
  String get importButton;

  /// No description provided for @exportSuccessMsg.
  ///
  /// In ja, this message translates to:
  /// **'エクスポートが完了しました'**
  String get exportSuccessMsg;

  /// No description provided for @importSuccessMsg.
  ///
  /// In ja, this message translates to:
  /// **'インポートが完了しました'**
  String get importSuccessMsg;

  /// No description provided for @exportErrorMsg.
  ///
  /// In ja, this message translates to:
  /// **'エクスポートに失敗しました: {message}'**
  String exportErrorMsg(String message);

  /// No description provided for @importErrorMsg.
  ///
  /// In ja, this message translates to:
  /// **'インポートに失敗しました: {message}'**
  String importErrorMsg(String message);

  /// No description provided for @dailyNotificationChannelName.
  ///
  /// In ja, this message translates to:
  /// **'デイリー通知'**
  String get dailyNotificationChannelName;

  /// No description provided for @dailyNotificationChannelDescription.
  ///
  /// In ja, this message translates to:
  /// **'今日のいいことを記録する時間をお知らせします'**
  String get dailyNotificationChannelDescription;

  /// No description provided for @dailyNotificationTitle.
  ///
  /// In ja, this message translates to:
  /// **'今日のいいこと'**
  String get dailyNotificationTitle;

  /// No description provided for @dailyNotificationBody.
  ///
  /// In ja, this message translates to:
  /// **'今日あった「いいこと」を記録しましょう☺️'**
  String get dailyNotificationBody;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'ko'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ko':
      return AppLocalizationsKo();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
