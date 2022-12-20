part of 'detail_movie_bloc.dart';

abstract class DetailMovieState extends Equatable {
  const DetailMovieState();
  
  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends DetailMovieState {}

class DetailMovieEmpty extends DetailMovieState {}
class DetailMovieLoading extends DetailMovieState{}
class DetailMovieError extends DetailMovieState {
  final String message;
 
  DetailMovieError(this.message);
 
  @override
  List<Object> get props => [message];
}
class DetailMovieHasData extends DetailMovieState {
  final MovieDetail detailMovie;
 
  DetailMovieHasData(this.detailMovie);
 
  @override
  List<Object> get props => [detailMovie];
}
