part of 'recommendation_tv_bloc.dart';

abstract class RecommendationTvEvent extends Equatable {}
class OnRecommendationTv extends RecommendationTvEvent {
  final int id;
  OnRecommendationTv(this.id);
  @override
  List<Object> get props => [id];
}