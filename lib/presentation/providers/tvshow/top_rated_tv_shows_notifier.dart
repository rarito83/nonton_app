import 'package:flutter/material.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_popular_tv_shows.dart';

class TopRatedTvShowsNotifier extends ChangeNotifier {
  final GetPopularTvShows getPopularTvShows;

  TopRatedTvShowsNotifier({
    required this.getPopularTvShows,
  });

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvShow> _tvShows = [];

  List<TvShow> get tvShow => _tvShows;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedTvShows() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvShows.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvShowsData) {
        _tvShows = tvShowsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
