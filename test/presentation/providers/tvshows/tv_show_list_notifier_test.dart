import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_now_playing_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_popular_tv_shows.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_top_rated_tv_show.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_list_notifier.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_show_notifier_test.mocks.dart';
import 'top_rated_tv_show_notifier_test.mocks.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([GetNowPlayingTvShows, GetPopularTvShows, GetTopRatedTvShows])
void main() {
  late TvShowListNotifier provider;
  late MockGetNowPlayingTvShows mockGetNowPlayingTVShows;
  late MockGetPopularTvShows mockGetPopularTVShows;
  late MockGetTopRatedTvShows mockGetTopRatedTVShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetNowPlayingTVShows = MockGetNowPlayingTvShows();
    mockGetPopularTVShows = MockGetPopularTvShows();
    mockGetTopRatedTVShows = MockGetTopRatedTvShows();

    provider = TvShowListNotifier(
      getNowPlayingTvShows: mockGetNowPlayingTVShows,
      getPopularTvShows: mockGetPopularTVShows,
      getTopRatedTvShows: mockGetTopRatedTVShows,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing tv shows', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingTvShowState, equals(RequestState.empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetNowPlayingTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      provider.fetchNowPlayingTvShows();
      // assert
      verify(mockGetNowPlayingTVShows.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetNowPlayingTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      provider.fetchNowPlayingTvShows();
      // assert
      expect(provider.nowPlayingTvShowState, RequestState.loading);
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetNowPlayingTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      await provider.fetchNowPlayingTvShows();
      // assert
      expect(provider.nowPlayingTvShowState, RequestState.loaded);
      expect(provider.nowPlayingTvShows, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetNowPlayingTVShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchNowPlayingTvShows();
      // assert
      expect(provider.nowPlayingTvShowState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      provider.fetchPopularTvShows();
      // assert
      expect(provider.popularTvShowState, RequestState.loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.nowPlayingTvShowState, RequestState.loaded);
      expect(provider.popularTvShows, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTvShows();
      // assert
      expect(provider.nowPlayingTvShowState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.loading);
    });

    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTVShows.execute())
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.loaded);
      expect(provider.topRatedTvShows, testTvShowList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVShows.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTvShows();
      // assert
      expect(provider.topRatedTvShowsState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
