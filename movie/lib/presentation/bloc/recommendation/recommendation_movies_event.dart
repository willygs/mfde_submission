part of 'recommendation_movies_bloc.dart';

abstract class RecommendationMoviesEvent extends Equatable {
}
class OnRecommendationMovies extends RecommendationMoviesEvent {

  final int id;
  
  OnRecommendationMovies(this.id);

  @override
  List<Object> get props => [id];
}