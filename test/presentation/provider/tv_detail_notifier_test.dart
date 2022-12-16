import 'package:dartz/dartz.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatusTv,
  SaveWatchlistTv,
  RemoveWatchlistTv
])
void main() {
  late TvDetailNotfier provider;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatusTv mockGetWatchListStatusTv;
  late MockSaveWatchlistTv mockSaveWatchlistTv;
  late MockRemoveWatchlistTv mockRemoveWatchlistTv;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchListStatusTv = MockGetWatchListStatusTv();
    mockSaveWatchlistTv = MockSaveWatchlistTv();
    mockRemoveWatchlistTv = MockRemoveWatchlistTv();
    provider = TvDetailNotfier(
        getTvDetail: mockGetTvDetail,
        getTvRecommendations: mockGetTvRecommendations,
        getWatchListStatusTv: mockGetWatchListStatusTv,
        saveWatchlistTv: mockSaveWatchlistTv,
        removeWatchlistTv: mockRemoveWatchlistTv)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final id = 130392;

  final tv = Tv(
      genreIds: [10764],
      name: "The D'Amelio Show",
      id: 130392,
      originCountry: ["US"],
      originalLanguage: 'en',
      originalName: "The D'Amelio Show",
      overview:
          "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
      popularity: 27.694,
      voteAverage: 8.994,
      voteCount: 3148);

  final tTv = <Tv>[tv];

  group('Get TV Detail', () {
    test('should get detail from the usecase', () async {
      //arrange
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(testTvDetail));
      //act
      await provider.fetchTvDetail(id);
      //assert
      verify(mockGetTvDetail.execute(id));
    });

    test('should change state to Loading  when usecase is called', () {
      //arrange
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(testTvDetail));
      //act
      provider.fetchTvDetail(id);
      //assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change detail tv when data is gotten successfully', () async {
      //arrange
      when(mockGetTvDetail.execute(id))
          .thenAnswer((_) async => Right(testTvDetail));
      //act
      await provider.fetchTvDetail(id);
      //assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tv, testTvDetail);
      expect(listenerCallCount, 2);
    });
  });

  group('Get TV Recommendations', () {
    test('should get recommendations from the usecase', () async {
      //arrange
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Right(tTv));
      //act
      await provider.fetchTvRecommendations(id);
      //assert
      verify(mockGetTvRecommendations.execute(id));
    });

    test('should change state to Loading  when usecase is called', () {
      //arrange
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Right(tTv));
      //act
      provider.fetchTvRecommendations(id);
      //assert
      expect(provider.recommendationState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change recommendation tv when data is gotten successfully',
        () async {
      //arrange
      when(mockGetTvRecommendations.execute(id))
          .thenAnswer((_) async => Right(tTv));
      //act
      await provider.fetchTvRecommendations(id);
      //assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.listTvRecommentations, tTv);
      expect(listenerCallCount, 2);
    });
  });
}
