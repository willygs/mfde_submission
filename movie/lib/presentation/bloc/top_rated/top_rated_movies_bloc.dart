import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_event.dart';
part 'top_rated_movies_state.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  late final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMoviesBloc(this._getTopRatedMovies) : super(TopRatedMoviesEmpty()) {
    on<OnTopRatedMovies>((event, emit) async {
    
       emit(TopRatedMoviesLoading());
      final result = await _getTopRatedMovies.execute();

      result.fold((failure) {
        emit(TopRatedMoviesError(failure.message));
      }, (data) {
        data.isEmpty
            ? emit(TopRatedMoviesEmpty())
            : emit(TopRatedMoviesHasData(data));
      });

    });
  }
}
