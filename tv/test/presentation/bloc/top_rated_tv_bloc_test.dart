import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/tv.dart';
import 'package:tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';

import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTv])
void main() {
  late MockGetTopRatedTv mockGetTopRatedTv;
  late TopRatedTvBloc topRatedTvBloc;

  setUp((){
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(mockGetTopRatedTv);
  });

  test('initial state should be empty', () {
    expect(topRatedTvBloc.state , TopRatedTvEmpty());
  });

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
  group('Top Rated TV', () {
    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvHasData(tTvList)
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, Error] when get to rated tv is unsuccessful',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        const TopRatedTvError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

    blocTest<TopRatedTvBloc, TopRatedTvState>(
      'Should emit [Loading, Empty] when get top rated is empty',
      build: () {
        when(mockGetTopRatedTv.execute())
            .thenAnswer((_) async => const Right([]) );
        return topRatedTvBloc;
      },
      act: (bloc) => bloc.add(OnTopRatedTv()),
      expect: () => [
        TopRatedTvLoading(),
        TopRatedTvEmpty()
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      },
    );

  });

}