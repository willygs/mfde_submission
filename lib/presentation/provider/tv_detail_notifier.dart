import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_recomendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_tv.dart';
import 'package:flutter/cupertino.dart';

class TvDetailNotfier extends ChangeNotifier {

  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';


  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatusTv getWatchListStatusTv;
  final SaveWatchlistTv saveWatchlistTv;
  final RemoveWatchlistTv removeWatchlistTv;

  TvDetailNotfier(
      {required this.getTvDetail,
      required this.getTvRecommendations,
      required this.getWatchListStatusTv,
      required this.saveWatchlistTv,
      required this.removeWatchlistTv});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  late TvDetail _tv;
  TvDetail get tv => _tv;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  List<Tv> _listTvRecommendations = [];
  List<Tv> get listTvRecommentations => _listTvRecommendations;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvDetail.execute(id);

    result.fold((failrue) {
      _state = RequestState.Error;
      _message = failrue.message;
      notifyListeners();
    }, (tvData) {
      _tv = tvData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchTvRecommendations(int id) async {
    _recommendationState = RequestState.Loading;
    notifyListeners();

    final result = await getTvRecommendations.execute(id);

    result.fold((failrue) {
      _recommendationState = RequestState.Error;
      _message = failrue.message;
      notifyListeners();
    }, (tvData) {
      _listTvRecommendations = tvData;
      _recommendationState = RequestState.Loaded;
      notifyListeners();
    });
  }

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _messageWatchlist = '';
  String get messageWatchlist => _messageWatchlist;

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTv.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlistTv.execute(tv);
    await result.fold((failure) async {
      _messageWatchlist = failure.message;
    }, (successMessage) async {
      _messageWatchlist = successMessage;
    });

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeWatchlist(TvDetail tv) async {
    final result = await removeWatchlistTv.execute(tv);
    await result.fold((failure) async {
      _messageWatchlist = failure.message;
    }, (successMessage) async {
      _messageWatchlist = successMessage;
    });

    await loadWatchlistStatus(tv.id);
  }
}
