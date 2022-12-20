
import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'now_playing_movies_test.mocks.dart';
import 'package:movie/presentation/bloc/now_playing/now_playing_movies_bloc.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  
  late NowPlayingMoviesBloc nowPlayingMoviesBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp((){
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMoviesBloc = NowPlayingMoviesBloc(mockGetNowPlayingMovies);
  });

   test('initial state should be empty', () {
    expect(
        nowPlayingMoviesBloc.state,
        NowPlayingMoviesEmpty()
        );
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  group('Now Playing Movies', () {
    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(tMovieList));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovies()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesHasData(tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Error] when get now playing is unsuccessful',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovies()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<NowPlayingMoviesBloc, NowPlayingMoviesState>(
      'Should emit [Loading, Empty] when get now playing is empty',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right([]) );
        return nowPlayingMoviesBloc;
      },
      act: (bloc) => bloc.add(OnNowPlayingMovies()),
      expect: () => [
        NowPlayingMoviesLoading(),
        NowPlayingMoviesEmpty()
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

  });

  

}