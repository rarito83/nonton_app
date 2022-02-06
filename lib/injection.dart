import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:nonton_app/data/datasources/db/database_helper.dart';
import 'package:nonton_app/data/datasources/movie_local_data_source.dart';
import 'package:nonton_app/data/datasources/movie_remote_data_source.dart';
import 'package:nonton_app/data/datasources/tv_show_local_data_source.dart';
import 'package:nonton_app/data/datasources/tv_show_remote_data_source.dart';
import 'package:nonton_app/data/repositories/movie_repository_impl.dart';
import 'package:nonton_app/data/repositories/tv_show_repository_impl.dart';
import 'package:nonton_app/domain/repositories/movie_repository.dart';
import 'package:nonton_app/domain/repositories/tv_show_repository.dart';
import 'package:nonton_app/domain/usecases/movie/get_movie_detail.dart';
import 'package:nonton_app/domain/usecases/movie/get_movie_recommendations.dart';
import 'package:nonton_app/domain/usecases/movie/get_now_playing_movies.dart';
import 'package:nonton_app/domain/usecases/movie/get_popular.movies.dart';
import 'package:nonton_app/domain/usecases/movie/get_top_rated_movies.dart';
import 'package:nonton_app/domain/usecases/movie/get_watchlist_movie_status.dart';
import 'package:nonton_app/domain/usecases/movie/get_watchlist_movies.dart';
import 'package:nonton_app/domain/usecases/movie/remove_movie_watchlist.dart';
import 'package:nonton_app/domain/usecases/movie/save_movie_watchlist.dart';
import 'package:nonton_app/domain/usecases/movie/search_movies.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_now_playing_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_popular_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_top_rated_tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_detail.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_recommendation.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_show_status.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/remove_tv_show_watchlist.dart';
import 'package:nonton_app/domain/usecases/tvshow/save_tv_show_watchlist.dart';
import 'package:nonton_app/domain/usecases/tvshow/search_tv_shows.dart';
import 'package:nonton_app/presentation/providers/home_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/movie_detail_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/movie_list_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/popular_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/top_rated_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/watchlist_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/search_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/popular_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/top_rated_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_detail_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_list_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/watchlist_tv_shows_notifier.dart';

final locator = GetIt.instance;

void init() {
  locator.registerFactory(
    () => HomeNotifier(),
  );

  locator.registerFactory(
    () => SearchNotifier(
      searchMovies: locator(),
      searchTvShows: locator(),
    ),
  );

  // provider movie
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListMovieStatus: locator(),
      saveMovieWatchlist: locator(),
      removeMovieWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  // provider tv show
  locator.registerFactory(
    () => TvShowListNotifier(
      getNowPlayingTvShows: locator(),
      getPopularTvShows: locator(),
      getTopRatedTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => TvShowDetailNotifier(
      getTvShowDetail: locator(),
      getTvShowRecommendations: locator(),
      getWatchlistTvShowStatus: locator(),
      saveTvShowWatchlist: locator(),
      removeTvShowWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularTvShowNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedTvShowsNotifier(
      getPopularTvShows: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistTvShowsNotifier(
      getWatchlistTvShows: locator(),
    ),
  );

  // use case movie
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListMovieStatus(locator()));
  locator.registerLazySingleton(() => SaveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case tv show
  locator.registerLazySingleton(() => GetNowPlayingTvShows(locator()));
  locator.registerLazySingleton(() => GetPopularTvShows(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvShows(locator()));
  locator.registerLazySingleton(() => GetTvShowDetail(locator()));
  locator.registerLazySingleton(() => GetTvShowRecommendation(locator()));
  locator.registerLazySingleton(() => SearchTvShows(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShowStatus(locator()));
  locator.registerLazySingleton(() => SaveTvShowWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvShowWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvShows(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<TvShowRepository>(
    () => TvShowRepositoryImpl(
      tvShowRemoteDataSource: locator(),
      tvShowLocalDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvShowRemoteDataSource>(
      () => TvShowRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvShowLocalDataSource>(
      () => TvShowLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
