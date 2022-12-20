part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();
  
  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}
class WatchlistTvEmpty extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvError extends WatchlistTvState {
  final String message;

 const WatchlistTvError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvHasData extends WatchlistTvState {
  final List<Tv> listWatchlist;

 const WatchlistTvHasData(this.listWatchlist);

  @override
  List<Object> get props => [listWatchlist];
}

class WatchlistTvIsAdded extends WatchlistTvState {
  final bool isAdded;

  const WatchlistTvIsAdded(this.isAdded);

  @override
  List<Object> get props => [isAdded];
}

class WatchlistTvMessage extends WatchlistTvState {
  final String message;

 const  WatchlistTvMessage(this.message);

  @override
  List<Object> get props => [message];
}
