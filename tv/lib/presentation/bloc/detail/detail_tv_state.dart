part of 'detail_tv_bloc.dart';

abstract class DetailTvState extends Equatable {
  const DetailTvState();
  
  @override
  List<Object> get props => [];
}


class DetailTvEmpty extends DetailTvState {}
class DetailTvLoading extends DetailTvState {}
class DetailTvError extends DetailTvState {
  final String message;
 
  const DetailTvError(this.message);
 
  @override
  List<Object> get props => [message];
}
class DetailTvHasData extends DetailTvState {
  final TvDetail tvDetail;
 
  const DetailTvHasData(this.tvDetail);
 
  @override
  List<Object> get props => [tvDetail];
}

