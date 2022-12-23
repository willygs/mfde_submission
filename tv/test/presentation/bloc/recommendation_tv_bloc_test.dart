
import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:tv/presentation/bloc/recommendation/recommendation_tv_bloc.dart';

import 'recommendation_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp((){
    mockGetTvRecommendations = MockGetTvRecommendations();
    recommendationTvBloc = RecommendationTvBloc(mockGetTvRecommendations);
  });

  test('initial state should be empty', () {
    expect(recommendationTvBloc.state, RecommendationTvEmpty());
  });

  const int id = 94605;

  final tTvModel = Tv(
    genreIds: const [16, 10765, 10759, 18],
    name: 'Arcane',
    id: 94605,
    originCountry: const ["US"],
    originalLanguage: 'en',
    originalName: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    popularity: 70.82,
    voteAverage: 8.747,
    voteCount: 2733);

final tTvList = <Tv>[tTvModel];
  group('Recommendation TV', () {
    blocTest<RecommendationTvBloc, RecommendationTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvRecommendations.execute(id))
            .thenAnswer((_) async => Right(tTvList));
        return recommendationTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTv(id)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        RecommendationTvLoading(),
        RecommendationTvHasData(tTvList)
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(id));
      },
    );

    blocTest<RecommendationTvBloc, RecommendationTvState>(
      'Should emit [Loading, Error] when get Recommendation tv is unsuccessful',
      build: () {
        when(mockGetTvRecommendations.execute(id))
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return recommendationTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTv(id)),
      expect: () => [
        RecommendationTvLoading(),
        const RecommendationTvError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(id));
      },
    );

    blocTest<RecommendationTvBloc, RecommendationTvState>(
      'Should emit [Loading, Empty] when get Recommendation is empty',
      build: () {
        when(mockGetTvRecommendations.execute(id))
            .thenAnswer((_) async => const Right([]) );
        return recommendationTvBloc;
      },
      act: (bloc) => bloc.add(OnRecommendationTv(id)),
      expect: () => [
        RecommendationTvLoading(),
        RecommendationTvEmpty()
      ],
      verify: (bloc) {
        verify(mockGetTvRecommendations.execute(id));
      },
    );

  });
}