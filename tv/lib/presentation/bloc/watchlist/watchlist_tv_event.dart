part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {}


class OnWatchlistTv extends WatchlistTvEvent {
  @override
  List<Object> get props => [];
}

class OnWatchlistTvStatus extends WatchlistTvEvent {

  final int id;

  OnWatchlistTvStatus(this.id);
 
   @override
  List<Object> get props => [id];
}

class OnWatchlistTvAdd extends WatchlistTvEvent {

  final TvDetail tvDetail;

  OnWatchlistTvAdd(this.tvDetail);
 
   @override
  List<Object> get props => [tvDetail];
}

class OnWatchlistTvRemove extends WatchlistTvEvent {

  final TvDetail tvDetail;

  OnWatchlistTvRemove(this.tvDetail);
 
   @override
  List<Object> get props => [tvDetail];
}