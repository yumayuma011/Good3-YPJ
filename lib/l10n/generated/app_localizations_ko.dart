// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => '오늘의 좋은 일';

  @override
  String get ok => '확인';

  @override
  String get cancel => '취소';

  @override
  String get navRecord => '기록';

  @override
  String get navCalendar => '캘린더';

  @override
  String get notifPermissionTitle => '매일 알림을 설정해보세요';

  @override
  String get notifPermissionBody =>
      '매일 정해진 시간에 \"오늘의 좋은 일\"을\n기록하도록 알려드립니다.\n알림은 설정 화면에서 언제든지 변경할 수 있습니다.';

  @override
  String get notifPermissionAllow => '알림 허용하기';

  @override
  String get notifPermissionSkip => '나중에 설정하기';

  @override
  String get recordCardTitle => '오늘의 기록';

  @override
  String get recordDateLabel => '날짜';

  @override
  String get recordPrompt => '오늘 있었던 좋은 일 3가지를 적어보세요\n아주 작은 일이라도 괜찮아요';

  @override
  String get recordPrompt2 => '생각나지 않아도 괜찮아요\n그대로 저장해보세요';

  @override
  String get recordSave => '저장하기';

  @override
  String get recordSavedBanner => '저장되었습니다';

  @override
  String get recordListTitle => '기록 내용';

  @override
  String get recordEmpty => '아직 기록이 없습니다';

  @override
  String get defaultFallbackItem => '오늘도 무사히 보냈다';

  @override
  String itemHint(int number) {
    return '좋은 일 $number';
  }

  @override
  String get calendarNoEntry => '이 날의 기록이 아직 없습니다';

  @override
  String get settingsCustomizeSection => '사용자 지정';

  @override
  String get settingsColorChange => '색상 변경';

  @override
  String get settingsDailyNotification => '데일리 알림 설정';

  @override
  String get settingsDataSection => '데이터';

  @override
  String get settingsImport => '데이터 가져오기';

  @override
  String get settingsExport => '데이터 내보내기';

  @override
  String get settingsSupportSection => '지원';

  @override
  String get settingsSupport => '지원';

  @override
  String get settingsManageDataSection => '데이터 관리';

  @override
  String get settingsResetAll => '모든 데이터 초기화';

  @override
  String get settingsRecommendedApps => '추천 앱';

  @override
  String settingsVersion(String version) {
    return 'Version $version';
  }

  @override
  String get resetConfirmTitle => '모든 데이터 초기화';

  @override
  String get resetConfirmBody =>
      '기록한 내용이 모두 삭제됩니다. 이 작업은 되돌릴 수 없습니다. 계속하시겠습니까?';

  @override
  String get resetConfirmDelete => '삭제하기';

  @override
  String get resetDoneSnackbar => '모든 데이터를 삭제했습니다';

  @override
  String get supportContact => '문의하기';

  @override
  String get supportFaq => '자주 묻는 질문';

  @override
  String get supportTerms => '이용약관';

  @override
  String get supportPrivacy => '개인정보처리방침';

  @override
  String get supportLegal => '특정상거래법에 따른 표기';

  @override
  String get supportOssLicense => '오픈소스 라이선스';

  @override
  String get contactSubject => '[오늘의 좋은 일] 문의';

  @override
  String get faqBody =>
      '자주 묻는 질문과 답변을 여기에 작성해 주세요.\n\nQ. 기록은 몇 건까지 저장할 수 있나요?\nA. 기기의 저장 공간이 허용하는 한 저장할 수 있습니다.\n\nQ. 데이터는 어디에 저장되나요?\nA. 기기 내에만 저장되며 외부로 전송되지 않습니다.';

  @override
  String get termsBody => '여기에 이용약관 내용을 작성해 주세요.';

  @override
  String get privacyBody => '여기에 개인정보처리방침 내용을 작성해 주세요.';

  @override
  String get legalBody => '여기에 특정상거래법에 따른 표기 내용을 작성해 주세요.';

  @override
  String get colorPickerTitle => '색상 변경';

  @override
  String get colorPickerPrompt => '원하는 색상을 선택해 주세요';

  @override
  String get notifSettingTitle => '데일리 알림 설정';

  @override
  String get notifEnableLabel => '알림 사용';

  @override
  String notifTimeLabel(String time) {
    return '알림 시각: $time';
  }

  @override
  String get exportTitle => '데이터 내보내기';

  @override
  String get importTitle => '데이터 가져오기';

  @override
  String get exportDesc => '기록한 데이터를 JSON 파일로 내보냅니다.\n백업이나 기기 변경 시 이용해 주세요.';

  @override
  String get importDesc => '이전에 내보낸 JSON 파일을 선택해 불러옵니다.\n※현재 데이터는 덮어쓰기됩니다.';

  @override
  String get exportButton => '내보내기';

  @override
  String get importButton => '파일 선택하기';

  @override
  String get exportSuccessMsg => '내보내기가 완료되었습니다';

  @override
  String get importSuccessMsg => '가져오기가 완료되었습니다';

  @override
  String exportErrorMsg(String message) {
    return '내보내기에 실패했습니다: $message';
  }

  @override
  String importErrorMsg(String message) {
    return '가져오기에 실패했습니다: $message';
  }

  @override
  String get dailyNotificationChannelName => '데일리 알림';

  @override
  String get dailyNotificationChannelDescription => '오늘의 좋은 일을 기록할 시간을 알려드립니다';

  @override
  String get dailyNotificationTitle => '오늘의 좋은 일';

  @override
  String get dailyNotificationBody => '오늘 있었던 좋은 일을 기록해봐요 ☺️';
}
