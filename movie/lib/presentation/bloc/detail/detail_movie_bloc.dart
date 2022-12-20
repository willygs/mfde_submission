import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {
  final GetMovieDetail _getMovieDetail;
  DetailMovieBloc(this._getMovieDetail) : super(DetailMovieEmpty()) {
    on<OnDetailMovie>((event, emit) async {

      final id = event.id;

      emit(DetailMovieLoading());
      
      final result = await _getMovieDetail.execute(id);
      result.fold((failure) {
        emit(DetailMovieError(failure.message));
      }, (data) {
        emit(DetailMovieHasData(data));
      });
    });
  }
}
