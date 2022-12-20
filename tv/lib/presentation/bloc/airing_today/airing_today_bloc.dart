import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_airing_today_tv.dart';

part 'airing_today_event.dart';
part 'airing_today_state.dart';

class AiringTodayBloc extends Bloc<AiringTodayEvent, AiringTodayState> {
  final GetAiringTodayTv _getAiringTodayTv;
  AiringTodayBloc(this._getAiringTodayTv) : super(AiringTodayEmpty()) {
    on<OnAiringToday>((event, emit) async {
       emit(AiringTodayLoading());
      final result = await _getAiringTodayTv.execute();

      result.fold((failure) {
        emit(AiringTodayError(failure.message));
      }, (data) {
        data.isEmpty
          ? emit(AiringTodayEmpty())
          : emit(AiringTodayHasData(data));
      });
    });
  }
}
