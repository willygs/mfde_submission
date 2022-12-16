
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/search_tv.dart';
import 'package:flutter/cupertino.dart';

class TvSearchNotifier extends ChangeNotifier {

  final SearchTv searchTv;
  TvSearchNotifier({required this.searchTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _listTv = [];
  List<Tv> get listTv =>  _listTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchSearchTv(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTv.execute(query);
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      }, (data){
        _listTv = data;
        _state = RequestState.Loaded;
        notifyListeners();
      });
  }
}