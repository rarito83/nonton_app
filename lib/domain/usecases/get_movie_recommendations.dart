import 'package:dartz/dartz.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/domain/entities/movie.dart';
import 'package:nonton_app/domain/repositories/movie_repository.dart';

class GetMovieRecommendations {
  final MovieRepository repository;

  GetMovieRecommendations(this.repository);

  Future<Either<Failure, List<Movie>>> execute(id) {
    return repository.getMovieRecommendations(id);
  }
}
