import 'package:flutter/material.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_shows.dart';

class WatchlistTvShowsNotifier extends ChangeNotifier {
  final GetWatchlistTvShows getWatchlistTvShows;

  WatchlistTvShowsNotifier({
    required this.getWatchlistTvShows,
  });

  var _watchlistTvShows = <TvShow>[];

  List<TvShow> get watchlistTvShows => _watchlistTvShows;

  var _watchlistState = RequestState.empty;

  RequestState get watchlistState => _watchlistState;

  String _message = "";

  String get message => _message;

  Future<void> fetchWatchlistTvShows() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlistTvShows.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowsData) {
        _watchlistState = RequestState.loaded;
        _watchlistTvShows = tvShowsData;
        notifyListeners();
      },
    );
  }
}
