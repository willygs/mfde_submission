part of 'watchlist_movies_bloc.dart';

abstract class WatchlistMoviesState extends Equatable {
  const WatchlistMoviesState();

  @override
  List<Object> get props => [];
}

class WatchlistMoviesInitial extends WatchlistMoviesState {
  @override
  List<Object> get props => [];
}

class WatchlistMoviesEmpty extends WatchlistMoviesState {}

class WatchlistMoviesLoading extends WatchlistMoviesState {}

class WatchlistMoviesError extends WatchlistMoviesState {
  final String message;

  const WatchlistMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMoviesHasData extends WatchlistMoviesState {
  final List<Movie> listWatchlist;

  const WatchlistMoviesHasData(this.listWatchlist);

  @override
  List<Object> get props => [listWatchlist];
}

class WatchlistMovieIsAdded extends WatchlistMoviesState {
  final bool isAdded;

  const WatchlistMovieIsAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistMovieMessage extends WatchlistMoviesState {
  final String message;

  const WatchlistMovieMessage(this.message);

  @override
  List<Object> get props => [message];
}
