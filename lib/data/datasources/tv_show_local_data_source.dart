import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/exception.dart';
import 'package:nonton_app/data/datasources/db/database_helper.dart';
import 'package:nonton_app/data/models/tv_show_table.dart';

abstract class TvShowLocalDataSource {
  Future<String> insertTvShowWatchlist(TvShowTable tvShowTable);

  Future<String> removeTvShowWatchlist(TvShowTable tvShowTable);

  Future<TvShowTable?> getTvShowById(int id);

  Future<List<TvShowTable>> getWatchlistTvShows();
}

class TvShowLocalDataSourceImpl with TvShowLocalDataSource {
  final DatabaseHelper databaseHelper;

  TvShowLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertTvShowWatchlist(TvShowTable tvShowTable) async {
    try {
      await databaseHelper.insertTvShowWatchlist(tvShowTable);
      return WATCHLIST_ADD_SUCCESS_MESSAGE;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeTvShowWatchlist(TvShowTable tvShowTable) async {
    try {
      await databaseHelper.removeTvShowWatchlist(tvShowTable);
      return WATCHLIST_REMOVE_SUCCESS_MESSAGE;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<TvShowTable?> getTvShowById(int id) async {
    final result = await databaseHelper.getTvShowById(id);
    if (result != null) {
      return TvShowTable.fromMap(result);
    }
  }

  @override
  Future<List<TvShowTable>> getWatchlistTvShows() async {
    final result = await databaseHelper.getWatchlistTvShows();
    return result.map((data) => TvShowTable.fromMap(data)).toList();
  }
}
