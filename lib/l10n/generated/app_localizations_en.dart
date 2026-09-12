// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => '3 Good Things Today';

  @override
  String get ok => 'OK';

  @override
  String get cancel => 'Cancel';

  @override
  String get navRecord => 'Record';

  @override
  String get navCalendar => 'Calendar';

  @override
  String get notifPermissionTitle => 'Set up your daily reminder';

  @override
  String get notifPermissionBody =>
      'We\'ll send a reminder every day at a set time to record your \"3 good things.\"\nYou can change this anytime from Settings.';

  @override
  String get notifPermissionAllow => 'Allow notifications';

  @override
  String get notifPermissionSkip => 'Set up later';

  @override
  String get recordCardTitle => 'Today\'s Record';

  @override
  String get recordDateLabel => 'Date';

  @override
  String get recordPrompt =>
      'Write down 3 good things that happened today\nEven the smallest things count';

  @override
  String get recordPrompt2 =>
      'Can\'t think of anything? That\'s okay\nJust save it as is';

  @override
  String get recordSave => 'Save';

  @override
  String get recordSavedBanner => 'Saved';

  @override
  String get recordListTitle => 'Records';

  @override
  String get recordEmpty => 'No records yet';

  @override
  String get defaultFallbackItem => 'I made it through today';

  @override
  String itemHint(int number) {
    return 'Good thing $number';
  }

  @override
  String get calendarNoEntry => 'No record for this day yet';

  @override
  String get settingsCustomizeSection => 'Customize';

  @override
  String get settingsColorChange => 'Change Color';

  @override
  String get settingsDailyNotification => 'Daily Notification Settings';

  @override
  String get settingsDataSection => 'Data';

  @override
  String get settingsImport => 'Import Data';

  @override
  String get settingsExport => 'Export Data';

  @override
  String get settingsSupportSection => 'Support';

  @override
  String get settingsSupport => 'Support';

  @override
  String get settingsManageDataSection => 'Manage Data';

  @override
  String get settingsResetAll => 'Reset All Data';

  @override
  String get settingsRecommendedApps => 'Recommended Apps';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get resetConfirmTitle => 'Reset All Data';

  @override
  String get resetConfirmBody =>
      'All recorded data will be deleted. This action cannot be undone. Are you sure?';

  @override
  String get resetConfirmDelete => 'Delete';

  @override
  String get resetDoneSnackbar => 'All data has been deleted';

  @override
  String get supportContact => 'Contact Us';

  @override
  String get supportFaq => 'FAQ';

  @override
  String get supportTerms => 'Terms of Service';

  @override
  String get supportPrivacy => 'Privacy Policy';

  @override
  String get supportLegal => 'Legal Notice';

  @override
  String get supportOssLicense => 'Open Source Licenses';

  @override
  String get contactSubject => '[3 Good Things Today] Inquiry';

  @override
  String get faqBody =>
      'Please write frequently asked questions and answers here.\n\nQ. How many records can I save?\nA. You can save as many as your device\'s storage allows.\n\nQ. Where is the data stored?\nA. It is stored only on your device and is never sent externally.';

  @override
  String get termsBody => 'Please write the terms of service here.';

  @override
  String get privacyBody => 'Please write the privacy policy here.';

  @override
  String get legalBody => 'Please write the legal notice content here.';

  @override
  String get colorPickerTitle => 'Change Color';

  @override
  String get colorPickerPrompt => 'Please choose your favorite color';

  @override
  String get notifSettingTitle => 'Daily Notification Settings';

  @override
  String get notifEnableLabel => 'Enable notifications';

  @override
  String notifTimeLabel(String time) {
    return 'Notification time: $time';
  }

  @override
  String get exportTitle => 'Export Data';

  @override
  String get importTitle => 'Import Data';

  @override
  String get exportDesc =>
      'Export your recorded data as a JSON file.\nUse this for backups or when switching devices.';

  @override
  String get importDesc =>
      'Select and load a previously exported JSON file.\n*This will overwrite your current data.';

  @override
  String get exportButton => 'Export';

  @override
  String get importButton => 'Choose File';

  @override
  String get exportSuccessMsg => 'Export completed';

  @override
  String get importSuccessMsg => 'Import completed';

  @override
  String exportErrorMsg(String message) {
    return 'Export failed: $message';
  }

  @override
  String importErrorMsg(String message) {
    return 'Import failed: $message';
  }

  @override
  String get dailyNotificationChannelName => 'Daily Reminder';

  @override
  String get dailyNotificationChannelDescription =>
      'Notifies you when it\'s time to record today\'s good things';

  @override
  String get dailyNotificationTitle => '3 Good Things Today';

  @override
  String get dailyNotificationBody =>
      'Would you like to record today\'s good things?';
}
