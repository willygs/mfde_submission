import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:core/data/datasources/tv_remote_data_source.dart';
import 'package:core/data/models/tv_detail_model.dart';
import 'package:core/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TvRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get airing today tv', () {
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/airing_today.json'))).tvList;

    test('should return list of TV Model when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/airing_today.json'), 200));

      //act
      final result = await dataSource.getAiringTodayTv();
      //assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response('Not Found', 404));

      //act
      final call =  dataSource.getAiringTodayTv();
      //assert
      expect(()=>call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv', () {
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/popular_tv.json'))).tvList;

    test('should return list of TV  when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/popular_tv.json'), 200));

      //act
      final result = await dataSource.getPopularTv();
      //assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response('Not Found', 404));

      //act
      final call =  dataSource.getPopularTv();
      //assert
      expect(()=>call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv', () {
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/top_rated_tv.json'))).tvList;

    test('should return list of TV  when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/top_rated_tv.json'), 200));

      //act
      final result = await dataSource.getTopRatedTv();
      //assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response('Not Found', 404));

      //act
      final call =  dataSource.getTopRatedTv();
      //assert
      expect(()=>call, throwsA(isA<ServerException>()));
    });
  });

  group('get detail tv', () {
    final id = 210855;
    final tTvDetail = TvDetailResponse.fromJson(
        json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return TV detail when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/tv_detail.json'), 200));

      //act
      final result = await dataSource.getTvDetail(id);
      //assert
      expect(result, equals(tTvDetail));
    });

    test('should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response('Not Found', 404));

      //act
      final call =  dataSource.getTvDetail(id);
      //assert
      expect(()=>call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv recommenations', () {
    final id = 210855;
    final tTvList = TvResponse.fromJson(
        json.decode(readJson('dummy_data/tv_recommendations.json'))).tvList;

    test('should return list of TV  when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/tv_recommendations.json'), 200));

      //act
      final result = await dataSource.getTvRecommendations(id);
      //assert
      expect(result, equals(tTvList));
    });

    test('should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
          .thenAnswer((realInvocation) async =>
              http.Response('Not Found', 404));

      //act
      final call =  dataSource.getTvRecommendations(id);
      //assert
      expect(()=>call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv', () {
    final query = 'faltu';
    final tSearchResult = TvResponse.fromJson(
        json.decode(readJson('dummy_data/search_faltu_tv.json'))).tvList;

    test('should return list of TV  when the response code is 200',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((realInvocation) async =>
              http.Response(readJson('dummy_data/search_faltu_tv.json'), 200));

      //act
      final result = await dataSource.searchTv(query);
      //assert
      expect(result, equals(tSearchResult));
    });

    test('should throw a ServerException when the response code is 404 or other',
        () async {
      //arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
          .thenAnswer((realInvocation) async =>
              http.Response('Not Found', 404));

      //act
      final call =  dataSource.searchTv(query);
      //assert
      expect(()=>call, throwsA(isA<ServerException>()));
    });
  });

}
