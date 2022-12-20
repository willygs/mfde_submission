part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesEvent extends Equatable {
  
}

class OnWatchlistMovies extends WatchlistMoviesEvent {
  @override
  List<Object> get props => [];
}

class OnWatchlistMoviesStatus extends WatchlistMoviesEvent {

  final int id;

  OnWatchlistMoviesStatus(this.id);
 
   @override
  List<Object> get props => [id];
}

class OnWatchlistMoviesAdd extends WatchlistMoviesEvent {

  final MovieDetail movieDetail;

  OnWatchlistMoviesAdd(this.movieDetail);
 
   @override
  List<Object> get props => [movieDetail];
}

class OnWatchlistMoviesRemove extends WatchlistMoviesEvent {

  final MovieDetail movieDetail;

  OnWatchlistMoviesRemove(this.movieDetail);
 
   @override
  List<Object> get props => [movieDetail];
}