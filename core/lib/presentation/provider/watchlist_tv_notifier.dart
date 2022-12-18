
import 'package:core/utils/state_enum.dart';

import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class WatchlistTvNotifier extends ChangeNotifier {

    final GetWatchlistTv getWatchlistTv;

    WatchlistTvNotifier({ required this.getWatchlistTv});

    var  _listTv = <Tv>[];
    List<Tv> get listTv => _listTv; 

    var _state = RequestState.Empty;
    RequestState get state => _state;

    String _message = '';
    String get message => _message;

    Future<void> fetchWatchlistTv() async {
      _state = RequestState.Loading;
      notifyListeners();
      final result = await getWatchlistTv.execute();
      result.fold(
        (failrue) async {
          _state =  RequestState.Error;
          _message = failrue.message;
          notifyListeners();
        } , 
        (dataTv) async {
          _state = RequestState.Loaded;
          _listTv = dataTv;
          notifyListeners();
        });
    }

}