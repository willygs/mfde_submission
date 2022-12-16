import 'dart:convert';

import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/models/tv_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
    backdropPath: "/cl8NLaoztP877hTSYSy6YIUkChF.jpg",
    posterPath: "/89kiLK0S7Rbfjorvhm0vxTAgAH3.jpg",
    genreIds: [10764],
    name: 'Now what',
    id: 210855,
    originCountry: ["BE"],
    originalLanguage: 'nl',
    originalName: 'Now what',
    overview:
        '7 young people co-house in Antwerp. They are all at the beginning of their adult life and have to decide what that should look like.',
    popularity: 1242.886,
    voteAverage: 4.4,
    voteCount: 5);

    final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

    group('fromJson', (){

      test('should return a valid model from JSON', ()async {

        //arrage
        final Map<String, dynamic> jsonMap = json.decode(readJson('dummy_data/airing_today.json'));
        //act
        final result = TvResponse.fromJson(jsonMap);
        //assert
        expect(result, tTvResponseModel);

      });
    });

    group('toJson', (){

      test('should return a JSON map containing proper data', () async {
        //arrage

        //act
        final result = tTvResponseModel.toJson();
        //assert
        final expectedjsonMap = {
          "results" :[
                  {
                    "backdrop_path": "/cl8NLaoztP877hTSYSy6YIUkChF.jpg",
                    "poster_path": "/89kiLK0S7Rbfjorvhm0vxTAgAH3.jpg",
                     "genre_ids": [
                      10764
                    ],
                     "name": "Now what",
                    "id": 210855,
                    "origin_country": [
                      "BE"
                    ],
                    "original_language": "nl",
                    "original_name": "Now what",
                    "overview": "7 young people co-house in Antwerp. They are all at the beginning of their adult life and have to decide what that should look like.",
                    "popularity": 1242.886,
                    "vote_average": 4.4,
                    "vote_count": 5
            }
          ]
        };
        expect(result, expectedjsonMap);
      });
    });

}