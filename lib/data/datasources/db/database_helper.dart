import 'dart:async';

import 'package:nonton_app/data/models/movie_table.dart';
import 'package:nonton_app/data/models/tv_show_table.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;

  DatabaseHelper._instance() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String _tblMovieWatchlist = 'movie_watchlist';
  static const String _tblTvShowWatchlist = 'tvShow_watchlist';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/ditonton.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $_tblMovieWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');

    await db.execute('''
       CREATE TABLE  $_tblTvShowWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  Future<int> insertMovieWatchlist(MovieTable movieTable) async {
    final db = await database;
    return await db!.insert(_tblMovieWatchlist, movieTable.toJson());
  }

  Future<int> insertTvShowWatchlist(TvShowTable tvShowTable) async {
    final db = await database;
    return await db!.insert(_tblTvShowWatchlist, tvShowTable.toJson());
  }

  Future<int> removeMovieWatchlist(MovieTable movieTable) async {
    final db = await database;
    return await db!.delete(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [movieTable.id],
    );
  }

  Future<int> removeTvShowWatchlist(TvShowTable tvShowTable) async {
    final db = await database;
    return await db!.delete(
      _tblTvShowWatchlist,
      where: 'id = ?',
      whereArgs: [tvShowTable.id],
    );
  }

  Future<Map<String, dynamic>?> getMovieById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblMovieWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<Map<String, dynamic>?> getTvShowById(int id) async {
    final db = await database;
    final results = await db!.query(
      _tblTvShowWatchlist,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getWatchlistMovies() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblMovieWatchlist);

    return results;
  }

  Future<List<Map<String, dynamic>>> getWatchlistTvShows() async {
    final db = await database;
    final List<Map<String, dynamic>> results =
        await db!.query(_tblTvShowWatchlist);

    return results;
  }
}
