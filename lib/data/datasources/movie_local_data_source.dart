import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/exception.dart';
import 'package:nonton_app/data/datasources/db/database_helper.dart';
import 'package:nonton_app/data/models/movie_table.dart';

abstract class MovieLocalDataSource {
  Future<String> insertMovieWatchlist(MovieTable movie);

  Future<String> removeMovieWatchlist(MovieTable movie);

  Future<MovieTable?> getMovieById(int id);

  Future<List<MovieTable>> getWatchlistMovies();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final DatabaseHelper databaseHelper;

  MovieLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertMovieWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.insertMovieWatchlist(movie);
      return WATCHLIST_ADD_SUCCESS_MESSAGE;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeMovieWatchlist(MovieTable movie) async {
    try {
      await databaseHelper.removeMovieWatchlist(movie);
      return WATCHLIST_REMOVE_SUCCESS_MESSAGE;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<MovieTable?> getMovieById(int id) async {
    final result = await databaseHelper.getMovieById(id);
    if (result != null) {
      return MovieTable.fromMap(result);
    }
  }

  @override
  Future<List<MovieTable>> getWatchlistMovies() async {
    final result = await databaseHelper.getWatchlistMovies();
    return result.map((data) => MovieTable.fromMap(data)).toList();
  }
}
