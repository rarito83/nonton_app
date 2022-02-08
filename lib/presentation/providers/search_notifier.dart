import 'package:flutter/foundation.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/movie.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/movie/search_movies.dart';
import 'package:nonton_app/domain/usecases/tvshow/search_tv_shows.dart';

class SearchNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;
  final SearchTvShows searchTvShows;

  SearchNotifier({
    required this.searchMovies,
    required this.searchTvShows,
  });

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Movie> _searchMoviesResult = [];

  List<Movie> get searchMovieResult => _searchMoviesResult;

  List<TvShow> _searchTvShowsResult = [];

  List<TvShow> get searchTvShowsResult => _searchTvShowsResult;

  String _message = '';

  String get message => _message;

  void resetSearch() {
    _state = RequestState.empty;
    _searchMoviesResult = [];
    _searchTvShowsResult = [];
    notifyListeners();
  }

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (dataMovie) {
        _searchMoviesResult = dataMovie;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }

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
      (dataTvShow) {
        _searchTvShowsResult = dataTvShow;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
