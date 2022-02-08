import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_shows.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlistTvShows usecase;
  late MockTvShowRepository mockTVShowRepository;

  setUp(() {
    mockTVShowRepository = MockTvShowRepository();
    usecase = GetWatchlistTvShows(mockTVShowRepository);
  });

  test('should get list of tv shows from the repository', () async {
    // arrange
    when(mockTVShowRepository.getWatchlistTvShows())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvShowList));
  });
}
