import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_recommendation.dart';

import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendation usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowRecommendation(mockTvShowRepository);
  });

  const tvId = 1;
  final tvShow = <TvShow>[];

  test('should get list of tv recommendations from the repository', () async {
    // arrange
    when(mockTvShowRepository.getTvShowRecommendations(tvId))
        .thenAnswer((_) async => Right(tvShow));
    // act
    final result = await usecase.execute(tvId);
    // assert
    expect(result, Right(tvShow));
  });
}
