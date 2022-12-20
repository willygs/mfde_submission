part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();
  
  @override
  List<Object> get props => [];
}


class PopularTvEmpty extends PopularTvState {}
class PopularTvLoading extends PopularTvState {}
class PopularTvError extends PopularTvState {
  final String message;
 
 const  PopularTvError(this.message);
 
  @override
  List<Object> get props => [message];
}
class PopularTvHasData extends PopularTvState {
  final List<Tv> listPopularTv;
 
  const PopularTvHasData(this.listPopularTv);
 
  @override
  List<Object> get props => [listPopularTv];
}
