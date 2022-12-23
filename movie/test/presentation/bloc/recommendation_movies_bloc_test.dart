import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/presentation/bloc/recommendation/recommendation_movies_bloc.dart';

import 'recommendation_movies_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late RecommendationMoviesBloc recommendationMoviesBloc;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMoviesBloc =
        RecommendationMoviesBloc(mockGetMovieRecommendations);
  });

  test('initial state should be empty', () {
    expect(recommendationMoviesBloc.state, RecommendationMoviesEmpty());
  });

  const int id = 1;

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
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

  group('Recommendation Movies', () {
    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(id))
            .thenAnswer((_) async => Right(tMovieList));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMovies(id)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        RecommendationMoviesLoading(),
        RecommendationMoviesHasData(tMovieList)
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(id));
      },
    );

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Error] when get recommendation movies is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(id))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMovies(id)),
      expect: () => [
        RecommendationMoviesLoading(),
        const RecommendationMoviesError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(id));
      },
    );

    blocTest<RecommendationMoviesBloc, RecommendationMoviesState>(
      'Should emit [Loading, Empty] when get popular is empty',
      build: () {
        when(mockGetMovieRecommendations.execute(id))
            .thenAnswer((_) async => const Right([]));
        return recommendationMoviesBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationMovies(id)),
      expect: () =>
          [RecommendationMoviesLoading(), RecommendationMoviesEmpty()],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(id));
      },
    );
  });
}