part of 'airing_today_bloc.dart';

abstract class AiringTodayState extends Equatable {
  const AiringTodayState();
  
  @override
  List<Object> get props => [];
}

class AiringTodayEmpty extends AiringTodayState {}
class AiringTodayLoading extends AiringTodayState {}
class AiringTodayError extends AiringTodayState {
  final String message;
 
  const AiringTodayError(this.message);
 
  @override
  List<Object> get props => [message];
}
class AiringTodayHasData extends AiringTodayState {
  final List<Tv> listAiringToday;
 
  const AiringTodayHasData(this.listAiringToday);
 
  @override
  List<Object> get props => [listAiringToday];
}