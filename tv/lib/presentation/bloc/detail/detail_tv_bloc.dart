import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';

part 'detail_tv_event.dart';
part 'detail_tv_state.dart';

class DetailTvBloc extends Bloc<DetailTvEvent, DetailTvState> {
  final GetTvDetail _getTvDetail;
  DetailTvBloc(this._getTvDetail) : super(DetailTvEmpty()) {
    on<OnDetailTv>((event, emit) async {
      final int id = event.id;
       emit(DetailTvLoading());
      final result = await _getTvDetail.execute(id);

      result.fold((failure) {
        emit(DetailTvError(failure.message));
      }, (data) {
        emit(DetailTvHasData(data));
      });
    });
  }
}
