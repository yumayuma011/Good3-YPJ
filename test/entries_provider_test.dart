import 'package:flutter_test/flutter_test.dart';
import 'package:good3_app_ypj/providers/entries_provider.dart';
import 'package:good3_app_ypj/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() {
    SharedPreferences.setMockInitialValues({});
  });

  test('blank fields do not overwrite an existing entry', () async {
    final provider = EntriesProvider(StorageService());
    final date = DateTime(2026, 8, 5);

    await provider.upsertEntry(
      date,
      ['existing 1', 'existing 2', 'existing 3'],
      fallbackItem: 'fallback',
    );
    await provider.upsertEntry(
      date,
      ['', 'updated 2', '   '],
      fallbackItem: 'fallback',
    );

    expect(provider.entryForDate(date)?.items, [
      'existing 1',
      'updated 2',
      'existing 3',
    ]);
  });

  test('an entirely blank new entry stores the fallback', () async {
    final provider = EntriesProvider(StorageService());
    final date = DateTime(2026, 8, 5);

    await provider.upsertEntry(
      date,
      ['', '', ''],
      fallbackItem: 'fallback',
    );

    expect(provider.entryForDate(date)?.items, [
      'fallback',
      '',
      '',
    ]);
  });
}
