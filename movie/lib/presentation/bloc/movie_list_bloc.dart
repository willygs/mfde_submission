import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  final GetPopularMovies _getPopularMovies;
  final GetTopRatedMovies _getTopRatedMovies;
  MovieListBloc(this._getNowPlayingMovies,this._getPopularMovies,this._getTopRatedMovies) : super(MovieListInitial(
    HomeNowPlayingMoviesEmpty(),
    HomePopularMoviesEmpty(),
    HomeTopRatedMoviesEmpty()
  )) {
    on<HomeNowPlayingMovies>((event, emit) async {
      
      emit(HomeNowPlayingMoviesLoading());
      final result = await _getNowPlayingMovies.execute();

      result.fold(
        (failure) {
          emit(HomeNowPlayingMoviesError(failure.message));
        }, 
        (data){
          emit(HomeNowPlayingMoviesHasData(data));
        });
    });

    on<HomePopularMovies>((event, emit) async {
      
      emit(HomePopularMoviesLoading());
      final result = await _getPopularMovies.execute();

      result.fold(
        (failure) {
          emit(HomePopularMoviesError(failure.message));
        }, 
        (data){
          emit(HomePopularMoviesHasData(data));
        });
    });

    on<HomeTopRatedMovies>((event, emit) async {
      
      emit(HomeTopRatedMoviesLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(HomeTopRatedMoviesError(failure.message));
        }, 
        (data){
          emit(HomeTopRatedMoviesHasData(data));
        });
    });

  }
}
