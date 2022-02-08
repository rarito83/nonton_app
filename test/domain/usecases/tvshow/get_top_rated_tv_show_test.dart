import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_top_rated_tv_show.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTvShows usecase;
  late MockTvShowRepository repository;
  setUp(() {
    repository = MockTvShowRepository();
    usecase = GetTopRatedTvShows(repository);
  });
  final testTv = <TvShow>[];
  test('should get list of tv when call getTopRated on repository', () async {
    //arrange
    when(repository.getTopRatedTvShows())
        .thenAnswer((realInvocation) async => Right(testTv));
    //act
    final result = await usecase.execute();
    //assert
    verify(repository.getTopRatedTvShows());
    expect(result, Right(testTv));
  });
}
