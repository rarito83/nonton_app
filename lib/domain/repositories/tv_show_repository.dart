import 'package:dartz/dartz.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/entities/tv_show_detail.dart';

abstract class TvShowRepository {
  Future<Either<Failure, List<TvShow>>> getNowPlayingTvShows();

  Future<Either<Failure, List<TvShow>>> getPopularTvShows();

  Future<Either<Failure, List<TvShow>>> getTopRatedTvShows();

  Future<Either<Failure, TvShowDetail>> getTvShowDetail(int id);

  Future<Either<Failure, List<TvShow>>> getTvShowRecommendations(int id);

  Future<Either<Failure, List<TvShow>>> searchTvShows(String query);

  Future<Either<Failure, String>> saveTvShowWatchlist(
      TvShowDetail tvShowDetail);

  Future<Either<Failure, String>> removeTvShowWatchlist(
      TvShowDetail tvShowDetail);

  Future<bool> isAddedToWatchlist(int id);

  Future<Either<Failure, List<TvShow>>> getWatchlistTvShows();
}
