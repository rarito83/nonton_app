import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/domain/usecases/tvshow/save_tv_show_watchlist.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvShowWatchlist usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = SaveTvShowWatchlist(mockTvShowRepository);
  });

  test('should save tv show to the repository', () async {
    // arrange
    when(mockTvShowRepository.saveTvShowWatchlist(testTvShowDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTvShowDetail);
    // assert
    verify(mockTvShowRepository.saveTvShowWatchlist(testTvShowDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
