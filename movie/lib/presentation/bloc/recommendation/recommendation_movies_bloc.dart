import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'recommendation_movies_event.dart';
part 'recommendation_movies_state.dart';

class RecommendationMoviesBloc
    extends Bloc<RecommendationMoviesEvent, RecommendationMoviesState> {
  final GetMovieRecommendations _getMovieRecommendations;
  RecommendationMoviesBloc(this._getMovieRecommendations)
      : super(RecommendationMoviesEmpty()) {
    on<OnRecommendationMovies>((event, emit) async {
      int id = event.id;
      emit(RecommendationMoviesLoading());
      final result = await _getMovieRecommendations.execute(id);

      result.fold((failure) {
        emit(RecommendationMoviesError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(RecommendationMoviesEmpty())
            : emit(RecommendationMoviesHasData(data));
      });
    });
  }
}
