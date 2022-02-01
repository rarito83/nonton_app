import 'package:dartz/dartz.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/domain/entities/movie_detail.dart';
import 'package:nonton_app/domain/repositories/movie_repository.dart';

class GetMovieDetail {
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  Future<Either<Failure, MovieDetail>> execute(int id) {
    return repository.getMovieDetail(id);
  }
}
