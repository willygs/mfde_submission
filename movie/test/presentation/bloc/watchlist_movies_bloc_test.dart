import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movies_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies,GetWatchListStatus,SaveWatchlist,RemoveWatchlist])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp((){
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(mockGetWatchlistMovies, mockGetWatchListStatus, mockSaveWatchlist, mockRemoveWatchlist);
  });

   test('initial state should be initial', () {
    expect(watchlistMovieBloc.state, WatchlistMoviesInitial());
  });

  group('Watchlist Movies', () {
    blocTest<WatchlistMovieBloc, WatchlistMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right([testWatchlistMovie]));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        WatchlistMoviesLoading(),
        WatchlistMoviesHasData([testWatchlistMovie])
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMoviesState>(
      'Should emit [Loading, Error] when get to watchlist Movie is unsuccessful',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => const Left(DatabaseFailure("Can't get data")));
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMovies()),
      expect: () => [WatchlistMoviesLoading(), const WatchlistMoviesError("Can't get data")],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });

  group('Watchlist Movie action', () {
    blocTest<WatchlistMovieBloc, WatchlistMoviesState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchListStatus.execute(1)).thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesStatus(1)),
      // wait: const Duration(milliseconds: 100),
      expect: () => [const WatchlistMovieIsAdded(true)],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(1));
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMoviesState>(
      'should execute save watchlist when function called',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Success'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesAdd(testMovieDetail)),
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMoviesState>(
      'should execute remove watchlist when function called',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Removed'));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesRemove(testMovieDetail)),
      verify: (bloc) {
        verify(mockRemoveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMoviesState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Left(DatabaseFailure('Failed')));
        when(mockGetWatchListStatus.execute(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return watchlistMovieBloc;
      },
      act: (bloc) => bloc.add(OnWatchlistMoviesAdd(testMovieDetail)),
      expect: () => [const WatchlistMoviesError('Failed'),const WatchlistMovieIsAdded(false)],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
  });
}