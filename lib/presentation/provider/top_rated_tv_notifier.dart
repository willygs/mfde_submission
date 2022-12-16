import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter/material.dart';

class TopRatedTvNotifier extends ChangeNotifier {
  final GetTopRatedTv getTopRatedTv;

  TopRatedTvNotifier(this.getTopRatedTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _listTv = [];
  List<Tv> get listTv => _listTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchTopRatedTv() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTv.execute();

    result.fold((failrue) {
      _state = RequestState.Error;
      _message = failrue.message;
      notifyListeners();
    }, (tvData) {
      _listTv = tvData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
