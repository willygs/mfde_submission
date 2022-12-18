import 'package:core/utils/state_enum.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_popular_tv.dart';
import 'package:flutter/cupertino.dart';

class PopularTvNotifier extends ChangeNotifier {
  
  final GetPopularTv getPopularTv;
  PopularTvNotifier(this.getPopularTv);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Tv> _listTv = [];
  List<Tv> get listTv => _listTv;

  String _message = '';
  String get message => _message;

  Future<void> fetchPopularTv() async {
    _state =  RequestState.Loading;
    notifyListeners();

    final result = await getPopularTv.execute();

    result.fold(
      (failrue) {
        _state = RequestState.Error;
        _message = failrue.message;
        notifyListeners();
      },
      (tvData) {
        _listTv = tvData;
        _state = RequestState.Loaded;
        notifyListeners();
      });
  }
}