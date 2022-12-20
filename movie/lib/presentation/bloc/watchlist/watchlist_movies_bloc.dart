import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_watchlist_movies.dart';
import 'package:movie/domain/usecases/get_watchlist_status.dart';
import 'package:movie/domain/usecases/remove_watchlist.dart';
import 'package:movie/domain/usecases/save_watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies _getWatchlistMovies;
  final GetWatchListStatus _getWatchListStatus;
  final SaveWatchlist _saveWatchlist;
  final RemoveWatchlist _removeWatchlist;
  WatchlistMovieBloc(this._getWatchlistMovies, this._getWatchListStatus,
      this._saveWatchlist, this._removeWatchlist)
      : super(WatchlistMoviesInitial()) {
    on<OnWatchlistMovies>(_onWatchlistMovies);
    on<OnWatchlistMoviesStatus>(_onWatchlistMoviesStatus);
    on<OnWatchlistMoviesAdd>(_onWatchlistMoviesAdd);
    on<OnWatchlistMoviesRemove>(_onWatchlistMoviesRemove);
  }

  Future<void> _onWatchlistMoviesStatus(
      OnWatchlistMoviesStatus event, Emitter<WatchlistMoviesState> emit) async {
    final id = event.id;
    final result = await _getWatchListStatus.execute(id);
    emit(WatchlistMovieIsAdded(result));
  }

  Future<void> _onWatchlistMoviesAdd(
      OnWatchlistMoviesAdd event, Emitter<WatchlistMoviesState> emit) async {
    final movie = event.movieDetail;

    final result = await _saveWatchlist.execute(movie);

    await result.fold((failure) async {
      emit(WatchlistMoviesError(failure.message));
    }, (data) async {
      emit(WatchlistMovieMessage(data));
    });
    OnWatchlistMoviesStatus status = OnWatchlistMoviesStatus(movie.id);
    await _onWatchlistMoviesStatus(status, emit);
  }

  Future<void> _onWatchlistMoviesRemove(
      OnWatchlistMoviesRemove event, Emitter<WatchlistMoviesState> emit) async {
    final movie = event.movieDetail;

    final result = await _removeWatchlist.execute(movie);

    await result.fold((failure) async {
      emit(WatchlistMoviesError(failure.message));
    }, (data) async {
      emit(WatchlistMovieMessage(data));
    });
    OnWatchlistMoviesStatus status = OnWatchlistMoviesStatus(movie.id);
    await _onWatchlistMoviesStatus(status, emit);
  }

  Future<void> _onWatchlistMovies(
      OnWatchlistMovies event, Emitter<WatchlistMoviesState> emit) async {
    emit(WatchlistMoviesLoading());
    final result = await _getWatchlistMovies.execute();

    result.fold((failure) {
      emit(WatchlistMoviesError(failure.message));
    }, (data) {
      data.isEmpty
          ? emit(WatchlistMoviesEmpty())
          : emit(WatchlistMoviesHasData(data));
    });
  }
}
