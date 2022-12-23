import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tv_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.insertWatchlistTv(testTvTable);
      //assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.insertWatchlistTv(testTvTable))
          .thenThrow(Exception());
      //act
      final call = dataSource.insertWatchlistTv(testTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 1);
      //act
      final result = await dataSource.removeWatchlistTv(testTvTable);
      //assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed',
        () async {
      //arrange
      when(mockDatabaseHelper.removeWatchlistTv(testTvTable))
          .thenThrow(Exception());
      //act
      final call = dataSource.insertWatchlistTv(testTvTable);
      //assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get TV Detail By Id', () {
    final id = 130392;
    test('should return TV Detail Table when data is found', () async {
      //arrange
      when(mockDatabaseHelper.geTvById(id)).thenAnswer((_) async => testTvMap);
      //act
      final result = await dataSource.getTvById(id);
      //assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      //arrange
      when(mockDatabaseHelper.geTvById(id)).thenAnswer((_) async => null);
      //act
      final result = await dataSource.getTvById(id);
      //assert
      expect(result, null);
    });
  });

  group('Get Watchlist TV', () {
    test('should return list of TvTable from database', () async {
      //arrange
      when(mockDatabaseHelper.getWatchlistTv())
          .thenAnswer((_) async => [testTvMap]);
      //act
      final result = await dataSource.getWatchlistTv();
      //assert
      expect(result, [testTvTable]);
    });
  });
}
