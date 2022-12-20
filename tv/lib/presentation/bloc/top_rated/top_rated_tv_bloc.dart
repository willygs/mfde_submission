import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'top_rated_tv_event.dart';
part 'top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv _getTopRatedTv;
  TopRatedTvBloc(this._getTopRatedTv) : super(TopRatedTvEmpty()) {
    on<OnTopRatedTv>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await _getTopRatedTv.execute();

      result.fold((failure) {
        emit(TopRatedTvError(failure.message));
      }, (data) {
        data.isEmpty ? emit(TopRatedTvEmpty()) : emit(TopRatedTvHasData(data));
      });
    });
  }
}
