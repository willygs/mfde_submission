part of 'search_tv_bloc.dart';

abstract class SearchTvEvent extends Equatable {
  const SearchTvEvent();

  @override
  List<Object> get props => [];
}


class OnQueryChanged extends SearchTvEvent {
  final String query;

  const OnQueryChanged(this.query);

  @override
  List<Object> get props => [query];

}