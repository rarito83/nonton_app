import 'package:flutter/material.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/entities/tv_show_detail.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_detail.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_recommendation.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_show_status.dart';
import 'package:nonton_app/domain/usecases/tvshow/remove_tv_show_watchlist.dart';
import 'package:nonton_app/domain/usecases/tvshow/save_tv_show_watchlist.dart';

class TvShowDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTvShowDetail getTvShowDetail;
  final GetTvShowRecommendation getTvShowRecommendations;
  final GetWatchlistTvShowStatus getWatchlistTvShowStatus;
  final SaveTvShowWatchlist saveTvShowWatchlist;
  final RemoveTvShowWatchlist removeTvShowWatchlist;

  TvShowDetailNotifier({
    required this.getTvShowDetail,
    required this.getTvShowRecommendations,
    required this.getWatchlistTvShowStatus,
    required this.saveTvShowWatchlist,
    required this.removeTvShowWatchlist,
  });

  late TvShowDetail _tvShowDetail;

  TvShowDetail get tvShowDetail => _tvShowDetail;

  RequestState _tvShowState = RequestState.empty;

  RequestState get tvShowState => _tvShowState;

  List<TvShow> _tvShowRecommndations = [];

  List<TvShow> get tvShowRecommendations => _tvShowRecommndations;

  RequestState _recommendationState = RequestState.empty;

  RequestState get recommendationState => _recommendationState;

  String _message = '';

  String get message => _message;

  bool _isAddedtoWatchlist = false;

  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTvShowDetail(int id) async {
    _tvShowState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvShowDetail.execute(id);
    final recommendationResult = await getTvShowRecommendations.execute(id);
    detailResult.fold(
      (failure) {
        _tvShowState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShow) {
        _recommendationState = RequestState.loading;
        _tvShowDetail = tvShow;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.error;
            _message = failure.message;
          },
          (tvShows) {
            _recommendationState = RequestState.loaded;
            _tvShowRecommndations = tvShows;
          },
        );
        _tvShowState = RequestState.loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';

  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvShowDetail tvShowDetail) async {
    final result = await saveTvShowWatchlist.execute(tvShowDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShowDetail.id);
  }

  Future<void> removeFromWatchlist(TvShowDetail tvShowDetail) async {
    final result = await removeTvShowWatchlist.execute(tvShowDetail);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvShowDetail.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchlistTvShowStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
