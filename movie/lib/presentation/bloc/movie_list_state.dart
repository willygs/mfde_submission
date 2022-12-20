part of 'movie_list_bloc.dart';

abstract class MovieListState extends Equatable {
  const MovieListState();
  
  @override
  List<Object> get props => [];
}

class HomeNowPlayingMoviesEmpty extends MovieListState {}
class HomeNowPlayingMoviesLoading extends MovieListState{}
class HomeNowPlayingMoviesError extends MovieListState {
  final String message;
 
  HomeNowPlayingMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}
class HomeNowPlayingMoviesHasData extends MovieListState {
  final List<Movie> listNowPlaying;
 
  HomeNowPlayingMoviesHasData(this.listNowPlaying);
 
  @override
  List<Object> get props => [listNowPlaying];
}

class HomePopularMoviesEmpty extends MovieListState {}
class HomePopularMoviesLoading extends MovieListState {}
class HomePopularMoviesError extends MovieListState {
  final String message;
 
  HomePopularMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}
class HomePopularMoviesHasData extends MovieListState {
  final List<Movie> listPopular;
 
  HomePopularMoviesHasData(this.listPopular);
 
  @override
  List<Object> get props => [listPopular];
}

class HomeTopRatedMoviesEmpty extends MovieListState {}
class HomeTopRatedMoviesLoading extends MovieListState {}
class HomeTopRatedMoviesError extends MovieListState {
  final String message;
 
  HomeTopRatedMoviesError(this.message);
 
  @override
  List<Object> get props => [message];
}
class HomeTopRatedMoviesHasData extends MovieListState {
  final List<Movie> listTopRated;
 
  HomeTopRatedMoviesHasData(this.listTopRated);
 
  @override
  List<Object> get props => [listTopRated];
}

class MovieListInitial extends MovieListState {
  final HomeNowPlayingMoviesEmpty homeNowPlayingMoviesEmpty;
  final HomePopularMoviesEmpty homePopularMoviesEmpty;
  final HomeTopRatedMoviesEmpty homeTopRatedMoviesEmpty;
 
  MovieListInitial(this.homeNowPlayingMoviesEmpty,this.homePopularMoviesEmpty,this.homeTopRatedMoviesEmpty);

  @override
  List<Object> get props => [homeNowPlayingMoviesEmpty,homePopularMoviesEmpty,homeTopRatedMoviesEmpty];

}