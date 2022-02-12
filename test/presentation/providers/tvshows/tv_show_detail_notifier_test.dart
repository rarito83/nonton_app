import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_detail.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_recommendation.dart';
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_show_status.dart';
import 'package:nonton_app/domain/usecases/tvshow/remove_tv_show_watchlist.dart';
import 'package:nonton_app/domain/usecases/tvshow/save_tv_show_watchlist.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_detail_notifier.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_show_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvShowDetail,
  GetTvShowRecommendation,
  GetWatchlistTvShowStatus,
  SaveTvShowWatchlist,
  RemoveTvShowWatchlist,
])
void main() {
  late TvShowDetailNotifier provider;
  late MockGetTvShowDetail mockGetTvShowDetail;
  late MockGetTvShowRecommendation mockGetTvShowRecommendation;
  late MockGetTvShowWatchlistStatus mockGetWatchlistTvShowStatus;
  late MockSaveTvShowWatchlist mockSaveWatchlist;
  late MockRemoveTvShowWatchlist mockRemoveWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvShowDetail = MockGetTvShowDetail();
    mockGetTvShowRecommendation = MockGetTvShowRecommendation();
    mockGetWatchlistTvShowStatus = MockGetTvShowWatchlistStatus();
    mockSaveWatchlist = MockSaveTvShowWatchlist();
    mockRemoveWatchlist = MockRemoveTvShowWatchlist();
    provider = TvShowDetailNotifier(
      getTvShowDetail: mockGetTvShowDetail,
      getTvShowRecommendations: mockGetTvShowRecommendation,
      getWatchlistTvShowStatus: mockGetWatchlistTvShowStatus,
      saveTvShowWatchlist: mockSaveWatchlist,
      removeTvShowWatchlist: mockRemoveWatchlist,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  const tvId = 1;

  void _arrangeUsecase() {
    when(mockGetTvShowDetail.execute(tvId))
        .thenAnswer((_) async => Right(testTvShowDetail));
    when(mockGetTvShowRecommendation.execute(tvId))
        .thenAnswer((_) async => Right(testTvShowList));
  }

  group('Get TVShow Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tvId);
      // assert
      verify(mockGetTvShowDetail.execute(tvId));
      verify(mockGetTvShowRecommendation.execute(tvId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvShowDetail(tvId);
      // assert
      expect(provider.tvShowState, RequestState.loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv show when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tvId);
      // assert
      expect(provider.tvShowState, RequestState.loaded);
      expect(provider.tvShowDetail, testTvShowDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation movies when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvShowDetail(tvId);
          // assert
          expect(provider.tvShowState, RequestState.loaded);
          expect(provider.tvShowRecommendations, testTvShowList);
        });
  });

  group('Get TVShow Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvShowDetail(tvId);
      // assert
      verify(mockGetTvShowRecommendation.execute(tvId));
      expect(provider.tvShowRecommendations, testTvShowList);
    });

    test('should update recommendation state when data is gotten successfully',
            () async {
          // arrange
          _arrangeUsecase();
          // act
          await provider.fetchTvShowDetail(tvId);
          // assert
          expect(provider.recommendationState, RequestState.loaded);
          expect(provider.tvShowRecommendations, testTvShowList);
        });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tvId))
          .thenAnswer((_) async => Right(testTvShowDetail));
      when(mockGetTvShowRecommendation.execute(tvId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvShowDetail(tvId);
      // assert
      expect(provider.recommendationState, RequestState.error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTvShowStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockSaveWatchlist.execute(testTvShowDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvShowDetail);
      // assert
      verify(mockRemoveWatchlist.execute(testTvShowDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      verify(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveWatchlist.execute(testTvShowDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTvShowStatus.execute(testTvShowDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTvShowDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvShowDetail.execute(tvId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvShowRecommendation.execute(tvId))
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      await provider.fetchTvShowDetail(tvId);
      // assert
      expect(provider.tvShowState, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
