import 'package:core/data/models/tv_model.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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

    test('should be a subclass of TV entity', () async {
      final result = tTvModel.toEntity();
      expect(result, tTv);
    });

}