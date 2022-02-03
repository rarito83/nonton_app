import 'package:flutter/material.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_now_playing_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_popular_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_top_rated_tv_show.dart';

class TvShowListNotifier extends ChangeNotifier {
  var _nowPlayingTvShows = <TvShow>[];

  List<TvShow> get nowPlayingTvShows => _nowPlayingTvShows;

  RequestState _nowPlayingTvShowState = RequestState.empty;

  RequestState get nowPlayingTvShowState => _nowPlayingTvShowState;

  var _popularTvShows = <TvShow>[];

  List<TvShow> get popularTvShows => _popularTvShows;

  RequestState _popularTvShowState = RequestState.empty;

  RequestState get popularTvShowState => _popularTvShowState;

  var _topRatedTvShows = <TvShow>[];

  List<TvShow> get topRatedTvShows => _topRatedTvShows;

  RequestState _topRatedTvShowsState = RequestState.empty;

  RequestState get topRatedTvShowsState => _topRatedTvShowsState;

  String _message = '';

  String get message => _message;

  TvShowListNotifier({
    required this.getNowPlayingTvShows,
    required this.getPopularTvShows,
    required this.getTopRatedTvShows,
  });

  final GetNowPlayingTvShows getNowPlayingTvShows;
  final GetPopularTvShows getPopularTvShows;
  final GetTopRatedTvShows getTopRatedTvShows;

  Future<void> fetchNowPlayingTvShows() async {
    _nowPlayingTvShowState = RequestState.loading;
    notifyListeners();

    final result = await getNowPlayingTvShows.execute();
    result.fold(
      (failure) {
        _nowPlayingTvShowState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _nowPlayingTvShowState = RequestState.loaded;
        _nowPlayingTvShows = tvShowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchPopularTvShows() async {
    _popularTvShowState = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();
    result.fold(
      (failure) {
        _popularTvShowState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _popularTvShowState = RequestState.loaded;
        _popularTvShows = tvShowData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTopRatedTvShows() async {
    _topRatedTvShowsState = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvShows.execute();
    result.fold(
      (failure) {
        _topRatedTvShowsState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (tvShowData) {
        _topRatedTvShowsState = RequestState.loaded;
        _topRatedTvShows = tvShowData;
        notifyListeners();
      },
    );
  }
}
