import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_tv_recomendations.dart';

part 'recommendation_tv_event.dart';
part 'recommendation_tv_state.dart';

class RecommendationTvBloc extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvRecommendations _getTvRecommendations;
  RecommendationTvBloc(this._getTvRecommendations) : super(RecommendationTvEmpty()) {
    on<OnRecommendationTv>((event, emit) async {
      final int id = event.id;
      emit(RecommendationTvLoading());
      final result = await _getTvRecommendations.execute(id);

      result.fold((failure) {
        emit(RecommendationTvError(failure.message));
      }, (data) {
        data.isEmpty ? emit(RecommendationTvEmpty()) : emit(RecommendationTvHasData(data));
      });
    });
  }
}
