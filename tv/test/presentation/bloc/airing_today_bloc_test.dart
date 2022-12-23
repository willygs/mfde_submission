import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_airing_today_tv.dart';
import 'package:tv/presentation/bloc/airing_today/airing_today_bloc.dart';
import 'airing_today_bloc_test.mocks.dart';

@GenerateMocks([GetAiringTodayTv])
void main() {
  late AiringTodayBloc airingTodayBloc;
  late MockGetAiringTodayTv mockGetAiringTodayTv;

  setUp((){
    mockGetAiringTodayTv = MockGetAiringTodayTv();
    airingTodayBloc = AiringTodayBloc(mockGetAiringTodayTv);
  });

  test('initial state should be empty', () {
    expect(
        airingTodayBloc.state,
        AiringTodayEmpty()
        );
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
  group('Airing Today TV', () {
    blocTest<AiringTodayBloc, AiringTodayState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetAiringTodayTv.execute())
            .thenAnswer((_) async => Right(tTvList));
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(OnAiringToday()),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        AiringTodayLoading(),
        AiringTodayHasData(tTvList)
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTv.execute());
      },
    );

    blocTest<AiringTodayBloc, AiringTodayState>(
      'Should emit [Loading, Error] when get airing today is unsuccessful',
      build: () {
        when(mockGetAiringTodayTv.execute())
            .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(OnAiringToday()),
      expect: () => [
        AiringTodayLoading(),
        const AiringTodayError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTv.execute());
      },
    );

    blocTest<AiringTodayBloc, AiringTodayState>(
      'Should emit [Loading, Empty] when get airing today is empty',
      build: () {
        when(mockGetAiringTodayTv.execute())
            .thenAnswer((_) async => const Right([]) );
        return airingTodayBloc;
      },
      act: (bloc) => bloc.add(OnAiringToday()),
      expect: () => [
        AiringTodayLoading(),
        AiringTodayEmpty()
      ],
      verify: (bloc) {
        verify(mockGetAiringTodayTv.execute());
      },
    );

  });

}