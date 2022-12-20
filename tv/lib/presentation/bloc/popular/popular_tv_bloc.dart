import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/tv.dart';

part 'popular_tv_event.dart';
part 'popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTv _getPopularTv;

  PopularTvBloc(this._getPopularTv) : super(PopularTvEmpty()) {
    on<PopularTvEvent>((event, emit) async {
      emit(PopularTvLoading());
      final result = await _getPopularTv.execute();

      result.fold((failure) {
        emit(PopularTvError(failure.message));
      }, (data) {
        data.isEmpty ? emit(PopularTvEmpty()) : emit(PopularTvHasData(data));
      });
    });
  }
}
