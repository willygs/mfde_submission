part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();
  
  @override
  List<Object> get props => [];
}


class RecommendationTvEmpty extends RecommendationTvState {}
class RecommendationTvLoading extends RecommendationTvState {}
class RecommendationTvError extends RecommendationTvState {
  final String message;
 
  const RecommendationTvError(this.message);
 
  @override
  List<Object> get props => [message];
}
class RecommendationTvHasData extends RecommendationTvState {
  final List<Tv> listRecommendationTv;
 
  const RecommendationTvHasData(this.listRecommendationTv);
 
  @override
  List<Object> get props => [listRecommendationTv];
}

