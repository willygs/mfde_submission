
import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/domain/usecases/search_tv.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTv mockSearchTv;

  setUp((){
    mockSearchTv = MockSearchTv();
    searchTvBloc = SearchTvBloc(mockSearchTv);
  }); 

  test('initial state should be empty', () {
    expect(searchTvBloc.state, SearchTvEmpty());
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
    const tQuery = 'Arcane';

    blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => Right(tTvList));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchTvLoading(), SearchTvHasData(tTvList)],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );

  blocTest<SearchTvBloc, SearchTvState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTv.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchTvBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [SearchTvLoading(), const SearchTvError('Server Failure')],
    verify: (bloc) {
      verify(mockSearchTv.execute(tQuery));
    },
  );
}