import 'package:flutter/material.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/search_tv_shows.dart';

class TvShowSearchNotifier extends ChangeNotifier {
  final SearchTvShows searchTvShows;

  TvShowSearchNotifier(this.searchTvShows);

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<TvShow> _searchResults = [];

  List<TvShow> get searchResult => _searchResults;

  String _message = '';

  String get message => _message;

  Future<void> fetchTvShowSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchTvShows.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (data) {
        _searchResults = data;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
