import 'package:dartz/dartz.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/domain/entities/movie_detail.dart';
import 'package:nonton_app/domain/repositories/movie_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;

  SaveWatchlist(this.repository);

  Future<Either<Failure, String>> execute(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
}
