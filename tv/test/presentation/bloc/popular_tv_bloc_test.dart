import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:tv/presentation/bloc/popular/popular_tv_bloc.dart';

import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTv])
void main() {
  late MockGetPopularTv mockGetPopularTv;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTv = MockGetPopularTv();
    popularTvBloc = PopularTvBloc(mockGetPopularTv);
  });

  test('initial state should be empty', () {
    expect(popularTvBloc.state, PopularTvEmpty());
  });

  final tTvModel = Tv(
    genreIds: [16, 10765, 10759, 18],
    name: 'Arcane',
    id: 94605,
    originCountry: ["US"],
    originalLanguage: 'en',
    originalName: 'Arcane',
    overview:
        'Amid the stark discord of twin cities Piltover and Zaun, two sisters fight on rival sides of a war between magic technologies and clashing convictions.',
    popularity: 70.82,
    voteAverage: 8.747,
    voteCount: 2733);

final tTvList = <Tv>[tTvModel];
  group('Popular TV', () {
    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        PopularTvLoading(),
        PopularTvHasData(tTvList)
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, Error] when get popular tv is unsuccessful',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      expect: () => [
        PopularTvLoading(),
        PopularTvError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

    blocTest<PopularTvBloc, PopularTvState>(
      'Should emit [Loading, Empty] when get popular is empty',
      build: () {
        when(mockGetPopularTv.execute())
            .thenAnswer((_) async => Right([]) );
        return popularTvBloc;
      },
      act: (bloc) => bloc.add(OnPopularTv()),
      expect: () => [
        PopularTvLoading(),
        PopularTvEmpty()
      ],
      verify: (bloc) {
        verify(mockGetPopularTv.execute());
      },
    );

  });
}
