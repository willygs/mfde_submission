import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';
import 'package:tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tv_bloc_test.mocks.dart';

@GenerateMocks(
    [GetWatchlistTv, GetWatchListStatusTv, SaveWatchlistTv, RemoveWatchlistTv])
void main() {
  late WatchlistTvBloc watchlistTvBloc;
  late MockGetWatchlistTv mockGetWatchlistTv;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;

  setUp(() {
    mockGetWatchlistTv = MockGetWatchlistTv();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    watchlistTvBloc = WatchlistTvBloc(mockGetWatchlistTv,
        mockGetWatchListStatusTv, mockSaveWatchlistTv, mockRemoveWatchlistTv);
  });

  test('initial state should be initial', () {
    expect(watchlistTvBloc.state, WatchlistTvInitial());
  });

  group('Watchlist TV', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Right([testWatchlistTv]));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData([testWatchlistTv])
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when get to watchlist tv is unsuccessful',
      build: () {
        when(mockGetWatchlistTv.execute())
            .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTv()),
      expect: () => [WatchlistTvLoading(), WatchlistTvError("Can't get data")],
      verify: (bloc) {
        verify(mockGetWatchlistTv.execute());
      },
    );
  });

  group('Watchlist tv action', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchListStatusTv.execute(1)).thenAnswer((_) async => true);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvStatus(1)),
      // wait: const Duration(milliseconds: 100),
      expect: () => [WatchlistTvIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatusTv.execute(1));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id))
            .thenAnswer((_) async => true);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvAdd(testTvDetail)),
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Right('Removed'));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvRemove(testTvDetail)),
      verify: (bloc) {
        verify(mockRemoveWatchlistTv.execute(testTvDetail));
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlistTv.execute(testTvDetail))
            .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatusTv.execute(testTvDetail.id))
            .thenAnswer((_) async => false);
        return watchlistTvBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistTvAdd(testTvDetail)),
      expect: () => [WatchlistTvError('Failed'),WatchlistTvIsAdded(false)],
      verify: (bloc) {
        verify(mockSaveWatchlistTv.execute(testTvDetail));
      },
    );
  });
}
