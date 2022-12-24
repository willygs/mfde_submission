import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:core/data/models/genre_model.dart';
import 'package:core/data/models/season_model.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_model.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    mockTvLocalDataSource = MockTvLocalDataSource();
    repository = TvRepositoryImpl(
        tvRemoteDataSource: mockTvRemoteDataSource,
        tvLocalDataSource: mockTvLocalDataSource);
  });

  final tTvModel = TvModel(
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

  final tTv = Tv(
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
  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('Airing Today TV', () {
    test(
        'should return remote  data tv when the call to remote data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getAiringTodayTv();
      //assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failrue when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenThrow(ServerException());
      //act
      final result = await repository.getAiringTodayTv();
      //assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failrue when the the device is no connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getAiringTodayTv();
      //assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return Certificate Verify Failed when verification certificate SSL Failed',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getAiringTodayTv())
          .thenThrow(TlsException('Certificate Verify Failed'));
      //act
      final result = await repository.getAiringTodayTv();
      //assert
      verify(mockTvRemoteDataSource.getAiringTodayTv());
      expect(result,
          equals(Left(SSLFailure('Certificate Verify Failed'))));
    });



  });

  group('Popular TV', () {
    test(
        'should return remote  data tv when the call to remote data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failrue when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv()).thenThrow(ServerException());
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failrue when the the device is no connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return Certificate Verify Failed when verification certificate SSL Failed',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getPopularTv())
          .thenThrow(TlsException('Certificate Verify Failed'));
      //act
      final result = await repository.getPopularTv();
      //assert
      verify(mockTvRemoteDataSource.getPopularTv());
      expect(result,
          equals(Left(SSLFailure('Certificate Verify Failed'))));
    });

  });

  group('Top Rated TV', () {
    test(
        'should return remote  data tv when the call to remote data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failrue when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv()).thenThrow(ServerException());
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failrue when the the device is no connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return Certificate Verify Failed when verification certificate SSL Failed',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTopRatedTv())
          .thenThrow(TlsException('Certificate Verify Failed'));
      //act
      final result = await repository.getTopRatedTv();
      //assert
      verify(mockTvRemoteDataSource.getTopRatedTv());
      expect(result,
          equals(Left(SSLFailure('Certificate Verify Failed'))));
    });


  });

  group('Get Detail TV', () {
    final id = 130392;
    final tTvResponse = TvDetailResponse(
        adult: false,
        backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
        genres: [GenreModel(id: 10764, name: "Reality")],
        homepage:
            "https://www.hulu.com/series/the-damelio-show-ad993806-7961-4eb3-9f92-e7b9a349ae22",
        id: id,
        name: "The D'Amelio Show",
        numberOfEpisodes: 18,
        numberOfSeasons: 2,
        originalLanguage: "en",
        originalName: "The D'Amelio Show",
        overview:
            "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
        popularity: 27.694,
        posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
        seasons: [
          SeasonModel(
              airDate: DateTime.parse("2021-09-03"),
              episodeCount: 8,
              id: 204453,
              name: "Season 1",
              posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
              overview: "",
              seasonNumber: 1),
          SeasonModel(
              airDate: DateTime.parse("2022-09-28"),
              episodeCount: 10,
              id: 303094,
              name: "Season 2",
              posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg",
              overview:
                  "As personal and professional relationships overlap, the D'Amelio family faces new challenges at every turn, from public scandals to maintaining mental health, as they share the truth behind their online lives.",
              seasonNumber: 2),
        ],
        status: "Returning Series",
        tagline: "Fame is one thing, family is everything.",
        type: "Reality",
        voteAverage: 8.994,
        voteCount: 3148);

    test(
        'should return detail tv data when the call to remote data source is successful',
        () async {
      //arrage
      when(mockTvRemoteDataSource.getTvDetail(id))
          .thenAnswer((_) async => tTvResponse);
      //act
      final result = await repository.getTvDetail(id);
      //assert
      verify(mockTvRemoteDataSource.getTvDetail(id));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return server failrue when the call to remote data source is unsuccessful',
        () async {
      //arrage
      when(mockTvRemoteDataSource.getTvDetail(id)).thenThrow(ServerException());
      //act
      final result = await repository.getTvDetail(id);
      //assert
      verify(mockTvRemoteDataSource.getTvDetail(id));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failrue when the the device is no connected to internet',
        () async {
      //arrage
      when(mockTvRemoteDataSource.getTvDetail(id))
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvDetail(id);
      //assert
      verify(mockTvRemoteDataSource.getTvDetail(id));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return Certificate Verify Failed when verification certificate SSL Failed',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTvDetail(id))
          .thenThrow(TlsException('Certificate Verify Failed'));
      //act
      final result = await repository.getTvDetail(id);
      //assert
      verify(mockTvRemoteDataSource.getTvDetail(id));
      expect(result,
          equals(Left(SSLFailure('Certificate Verify Failed'))));
    });

  });

  group('Get TV recommendations', () {
    final tTvList = <TvModel>[];
    final id = 130392;

    test(
        'should return list tv recommendations data when the call to remote data source is successful',
        () async {
      //arrage
      when(mockTvRemoteDataSource.getTvRecommendations(id))
          .thenAnswer((_) async => tTvList);
      //act
      final result = await repository.getTvRecommendations(id);
      //assert
      verify(mockTvRemoteDataSource.getTvRecommendations(id));
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failrue when the call to remote data source is unsuccessful',
        () async {
      //arrage
      when(mockTvRemoteDataSource.getTvRecommendations(id))
          .thenThrow(ServerException());
      //act
      final result = await repository.getTvRecommendations(id);
      //assert
      verify(mockTvRemoteDataSource.getTvRecommendations(id));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failrue when the the device is no connected to internet',
        () async {
      //arrage
      when(mockTvRemoteDataSource.getTvRecommendations(id))
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.getTvRecommendations(id);
      //assert
      verify(mockTvRemoteDataSource.getTvRecommendations(id));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });

    test(
        'should return Certificate Verify Failed when verification certificate SSL Failed',
        () async {
      //arrange
      when(mockTvRemoteDataSource.getTvRecommendations(id))
          .thenThrow(TlsException('Certificate Verify Failed'));
      //act
      final result = await repository.getTvRecommendations(id);
      //assert
      verify(mockTvRemoteDataSource.getTvRecommendations(id));
      expect(result,
          equals(Left(SSLFailure('Certificate Verify Failed'))));
    });

  });

  group('get watchlist status', () {
    test('should return watch status wheter is found', () async {
      //arrage
      final id = 130392;
      when(mockTvLocalDataSource.getTvById(id)).thenAnswer((_) async => null);
      //act
      final result = await repository.isAddedToWatchlistTv(id);
      //assert
      expect(result, false);
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      //arrage
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      //act
      final result = await repository.saveWatchlistTv(testTvDetail);
      //assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      //arrage
      when(mockTvLocalDataSource.insertWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      //act
      final result = await repository.saveWatchlistTv(testTvDetail);
      //assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('Remove watchlist', () {
    test('should return success message when remove successful', () async {
      //arrage
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      //act
      final result = await repository.removeWatchlistTv(testTvDetail);
      //assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      //arrage
      when(mockTvLocalDataSource.removeWatchlistTv(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      //act
      final result = await repository.removeWatchlistTv(testTvDetail);
      //assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist tv', () {
    test('should return list of tv', () async {
      //arrage
      when(mockTvLocalDataSource.getWatchlistTv())
          .thenAnswer((_) async => [testTvTable]);
      //act
      final result = await repository.getWatchlistTv();
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTv]);
    });
  });

  group('Search TV', () {
    final query = "The D'Amelio Show";
    test(
        'should return tv list when call to data source is successful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.searchTv(query))
          .thenAnswer((_) async => tTvModelList);
      //act
      final result = await repository.searchTv(query);
      //assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failrue when the call to remote data source is unsuccessful',
        () async {
      //arrange
      when(mockTvRemoteDataSource.searchTv(query))
          .thenThrow(ServerException());
      //act
      final result = await repository.searchTv(query);
      //assert
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failrue when the the device is no connected to internet',
        () async {
      //arrange
      when(mockTvRemoteDataSource.searchTv(query))
          .thenThrow(SocketException('Failed to connect to the network'));
      //act
      final result = await repository.searchTv(query);
      //assert
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });
}
