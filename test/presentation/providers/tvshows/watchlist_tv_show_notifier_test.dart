import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_shows.dart';
import 'package:nonton_app/presentation/providers/tvshow/watchlist_tv_shows_notifier.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_show_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistTvShows])
void main() {
  late WatchlistTvShowsNotifier provider;
  late MockGetWatchlistTvShows mockGetWatchlistTVShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlistTVShows = MockGetWatchlistTvShows();
    provider = WatchlistTvShowsNotifier(
      getWatchlistTvShows: mockGetWatchlistTVShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  test('should change tv shows data when data is gotten successfully',
      () async {
    // arrange
    when(mockGetWatchlistTVShows.execute())
        .thenAnswer((_) async => Right(testWatchlistTvShow));
    // act
    await provider.fetchWatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.loaded);
    expect(provider.watchlistTvShows, testWatchlistTvShow);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetWatchlistTVShows.execute())
        .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
    // act
    await provider.fetchWatchlistTvShows();
    // assert
    expect(provider.watchlistState, RequestState.error);
    expect(provider.message, "Can't get data");
    expect(listenerCallCount, 2);
  });
}
