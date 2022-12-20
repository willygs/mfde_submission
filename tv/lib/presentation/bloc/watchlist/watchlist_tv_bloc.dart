import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:tv/domain/usecases/get_watchlist_status_tv.dart';
import 'package:tv/domain/usecases/get_watchlist_tv.dart';
import 'package:tv/domain/usecases/remove_watchlist_tv.dart';
import 'package:tv/domain/usecases/save_watchlist_tv.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTv _getWatchlistTv;
  final GetWatchListStatusTv _getWatchListStatusTv;
  final SaveWatchlistTv _saveWatchlistTv;
  final RemoveWatchlistTv _removeWatchlistTv;
  WatchlistTvBloc(
    this._getWatchlistTv,
    this._getWatchListStatusTv,
    this._saveWatchlistTv,
    this._removeWatchlistTv
  ) : super(WatchlistTvInitial()) {
   on<OnWatchlistTv>(_onWatchlistTv);
    on<OnWatchlistTvStatus>(_onWatchlistTvStatus);
    on<OnWatchlistTvAdd>(_onWatchlistTvAdd);
    on<OnWatchlistTvRemove>(_onWatchlistTvRemove);
  }

  Future<void> _onWatchlistTvStatus(
      OnWatchlistTvStatus event, Emitter<WatchlistTvState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatusTv.execute(id);
    emit(WatchlistTvIsAdded(result));
  }

  Future<void> _onWatchlistTvAdd(
      OnWatchlistTvAdd event, Emitter<WatchlistTvState> emit) async {
    final tv = event.tvDetail;

    final result = await _saveWatchlistTv.execute(tv);

    await result.fold((failure) async {
      emit(WatchlistTvError(failure.message));
    }, (data) async {
      emit(WatchlistTvMessage(data));
    });
    OnWatchlistTvStatus status = OnWatchlistTvStatus(tv.id);
    await _onWatchlistTvStatus(status, emit);
  }

  Future<void> _onWatchlistTvRemove(
      OnWatchlistTvRemove event, Emitter<WatchlistTvState> emit) async {
    final tv = event.tvDetail;

    final result = await _removeWatchlistTv.execute(tv);

    await result.fold((failure) async {
      emit(WatchlistTvError(failure.message));
    }, (data) async {
      emit(WatchlistTvMessage(data));
    });
    OnWatchlistTvStatus status = OnWatchlistTvStatus(tv.id);
    await _onWatchlistTvStatus(status, emit);
  }

  Future<void> _onWatchlistTv(
      OnWatchlistTv event, Emitter<WatchlistTvState> emit) async {
    emit(WatchlistTvLoading());
    final result = await _getWatchlistTv.execute();

    result.fold((failure) {
      emit(WatchlistTvError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(WatchlistTvEmpty())
          : emit(WatchlistTvHasData(data));
    });
  }
}
