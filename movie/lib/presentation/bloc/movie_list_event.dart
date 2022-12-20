part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class HomeNowPlayingMovies extends MovieListEvent {}
class HomePopularMovies extends MovieListEvent {}
class HomeTopRatedMovies extends MovieListEvent {}