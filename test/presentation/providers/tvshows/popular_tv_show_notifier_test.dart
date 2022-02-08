import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_popular_tv_shows.dart';
import 'package:nonton_app/presentation/providers/tvshow/popular_tv_shows_notifier.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_show_notifier_test.mocks.dart';

@GenerateMocks([GetPopularTvShows])
void main() {
  late MockGetPopularTvShows mockGetPopularTvShow;
  late PopularTvShowNotifier notifier;
  late int listenerCallCount;
  setUp(() {
    listenerCallCount = 0;
    mockGetPopularTvShow = MockGetPopularTvShows();
    notifier = PopularTvShowNotifier(mockGetPopularTvShow)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetPopularTvShow.execute())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetPopularTvShow.execute())
        .thenAnswer((_) async => Right(testTvShowList));
    // act
    await notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvShow, testTvShowList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetPopularTvShow.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchPopularTvShows();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
