import 'package:core/utils/state_enum.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_airing_today_tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import '../../domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TvListNotfier extends ChangeNotifier {

  var _airingTodayTv = <Tv>[];
  List<Tv> get airingTodayTv => _airingTodayTv;

  RequestState _airingTodayState = RequestState.Empty;
  RequestState get airingTodayState => _airingTodayState;

  var _popularTv = <Tv>[];
  List<Tv> get popularTv => _popularTv;

  RequestState _popularTvState = RequestState.Empty;
  RequestState get popularTvState => _popularTvState;

  var _topRatedTv = <Tv>[];
  List<Tv> get topRatedTv => _topRatedTv;

  RequestState _topRatedTvState = RequestState.Empty;
  RequestState get topRatedTvState => _topRatedTvState;


  String _message = '';
  String get message => _message;

  TvListNotfier({
    required this.getAiringTodayTv,
    required this.getPopularTv,
    required this.getTopRatedTv
  });

  final GetAiringTodayTv getAiringTodayTv;
  final GetPopularTv getPopularTv;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchAiringTodayTv() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result =  await getAiringTodayTv.execute();
    result.fold(
      (failrue) {
        _airingTodayState = RequestState.Error;
        _message = failrue.message;
        notifyListeners();
      }, 
      (tvData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTv = tvData;
        notifyListeners();
      });
  } 

  Future<void> fetchPopularTv() async {
    _popularTvState =  RequestState.Loading;
    notifyListeners();

    final result =  await getPopularTv.execute();
    result.fold(
      (failrue) {
        _popularTvState = RequestState.Error;
        _message = failrue.message;
        notifyListeners();
      }, 
      (tvData) {
        _popularTvState = RequestState.Loaded;
        _popularTv = tvData;
        notifyListeners();
      });
  }

  Future<void> fetchTopRatedTv() async {
    _topRatedTvState =  RequestState.Loading;
    notifyListeners();

    final result =  await getTopRatedTv.execute();
    result.fold(
      (failrue) {
        _topRatedTvState = RequestState.Error;
        _message = failrue.message;
        notifyListeners();
      }, 
      (tvData) {
        _topRatedTvState = RequestState.Loaded;
        _topRatedTv = tvData;
        notifyListeners();
      });
  }
}