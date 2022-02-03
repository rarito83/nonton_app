import 'package:dartz/dartz.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/repositories/tv_show_repository.dart';

class GetWatchlistTvShows {
  final TvShowRepository repository;

  GetWatchlistTvShows(this.repository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return repository.getWatchlistTvShows();
  }
}