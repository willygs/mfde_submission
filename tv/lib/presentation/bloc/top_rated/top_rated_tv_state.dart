part of 'top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();
  
  @override
  List<Object> get props => [];
}



class TopRatedTvEmpty extends TopRatedTvState {}
class TopRatedTvLoading extends TopRatedTvState {}
class TopRatedTvError extends TopRatedTvState {
  final String message;
 
  const TopRatedTvError(this.message);
 
  @override
  List<Object> get props => [message];
}
class TopRatedTvHasData extends TopRatedTvState {
  final List<Tv> listTopRatedTv;
 
  const TopRatedTvHasData(this.listTopRatedTv);
 
  @override
  List<Object> get props => [listTopRatedTv];
}

