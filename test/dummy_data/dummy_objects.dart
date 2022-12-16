import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/tv_table.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};

//test dummy tv
final testTv = Tv(
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

final testTvList = [testTv];

final testTvDetail = TvDetail(
    adult: false,
    backdropPath: "/7q448EVOnuE3gVAx24krzO7SNXM.jpg",
    genres: [Genre(id: 10764, name: "Reality")],
    homepage:
        "https://www.hulu.com/series/the-damelio-show-ad993806-7961-4eb3-9f92-e7b9a349ae22",
    id: 130392,
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
      Season(
        airDate: DateTime.parse("2021-09-03"),
        episodeCount: 8,
        id: 204453,
        name: "Season 1",
        overview: "",
        seasonNumber: 1,
        posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
      ),
      Season(
          airDate: DateTime.parse("2022-09-28"),
          episodeCount: 10,
          id: 303094,
          name: "Season 2",
          overview:
              "As personal and professional relationships overlap, the D'Amelio family faces new challenges at every turn, from public scandals to maintaining mental health, as they share the truth behind their online lives.",
          seasonNumber: 2,
          posterPath: "/phv2Jc4H8cvRzvTKb9X1uKMboTu.jpg"),
    ],
    status: "Returning Series",
    tagline: "Fame is one thing, family is everything.",
    type: "Reality",
    voteAverage: 8.994,
    voteCount: 3148);
final testTvTable = TvTable(
  id: 130392,
  name: "The D'Amelio Show",
  posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
  overview:
      "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
);

final testWatchlistTv = Tv.watchlist(
  id: 130392,
  name: "The D'Amelio Show",
  posterPath: "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
  overview:
      "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
);

final testTvMap = {
  'id': 130392,
  'overview': "From relative obscurity and a seemingly normal life, to overnight success and thrust into the Hollywood limelight overnight, the D’Amelios are faced with new challenges and opportunities they could not have imagined.",
  'posterPath': "/z0iCS5Znx7TeRwlYSd4c01Z0lFx.jpg",
  'name': "The D'Amelio Show",
};
