import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/exception.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/data/repositories/tv_show_repository_impl.dart';

import '../../dummy_data/dummy_objects_tv.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvShowRepositoryImpl repository;
  late MockTvShowRemoteDataSource mockRemoteDataSource;
  late MockTvShowLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTvShowRemoteDataSource();
    mockLocalDataSource = MockTvShowLocalDataSource();
    repository = TvShowRepositoryImpl(
      tvShowRemoteDataSource: mockRemoteDataSource,
      tvShowLocalDataSource: mockLocalDataSource,
    );
  });

  group("Now Playing Tv Shows", () {
    test(
        'should return remote data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvShows())
              .thenAnswer((_) async => testTvShowModelList);
          // act
          final result = await repository.getNowPlayingTvShows();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvShows());
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvShowList);
        });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvShows())
              .thenThrow(ServerException());
          // act
          final result = await repository.getNowPlayingTvShows();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvShows());
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getNowPlayingTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getNowPlayingTvShows();
          // assert
          verify(mockRemoteDataSource.getNowPlayingTvShows());
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Popular Tv Shows', () {
    test('should return tv show list when call to data source is success',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenAnswer((_) async => testTvShowModelList);
          // act
          final result = await repository.getPopularTvShows();
          // assert
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvShowList);
        });

    test(
        'should return server failure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenThrow(ServerFailure(''));
          // act
          final result = await repository.getPopularTvShows();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return connection failure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getPopularTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getPopularTvShows();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Top Rated Tv Shows', () {
    test('should return tv show list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenAnswer((_) async => testTvShowModelList);
          // act
          final result = await repository.getTopRatedTvShows();
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvShowList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenThrow(ServerFailure(''));
          // act
          final result = await repository.getTopRatedTvShows();
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTopRatedTvShows())
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTopRatedTvShows();
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('Get TV Show Detail', () {
    const tvId = 1;

    test(
        'should return TV Show data when the call to remote data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowDetail(tvId))
              .thenAnswer((_) async => testTvShowDetailResponse);
          // act
          final result = await repository.getTvShowDetail(tvId);
          // assert
          verify(mockRemoteDataSource.getTvShowDetail(tvId));
          expect(result, equals(Right(testTvShowDetail)));
        });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowDetail(tvId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvShowDetail(tvId);
          // assert
          verify(mockRemoteDataSource.getTvShowDetail(tvId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowDetail(tvId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvShowDetail(tvId);
          // assert
          verify(mockRemoteDataSource.getTvShowDetail(tvId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Get Tv Shows Recommendations', () {
    const tvId = 1;

    test('should return data (tv show list) when the call is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tvId))
              .thenAnswer((_) async => testTvShowModelList);
          // act
          final result = await repository.getTvShowRecommendations(tvId);
          // assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tvId));
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, equals(testTvShowList));
        });

    test(
        'should return server failure when call to remote data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tvId))
              .thenThrow(ServerException());
          // act
          final result = await repository.getTvShowRecommendations(tvId);
          // assertbuild runner
          verify(mockRemoteDataSource.getTvShowRecommendations(tvId));
          expect(result, equals(Left(ServerFailure(''))));
        });

    test(
        'should return connection failure when the device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.getTvShowRecommendations(tvId))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.getTvShowRecommendations(tvId);
          // assert
          verify(mockRemoteDataSource.getTvShowRecommendations(tvId));
          expect(result,
              equals(Left(ConnectionFailure('Failed to connect to the network'))));
        });
  });

  group('Search Tv Shows', () {
    const tQuery = 'spiderman';

    test('should return movie list when call to data source is successful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenAnswer((_) async => testTvShowModelList);
          // act
          final result = await repository.searchTvShows(tQuery);
          // assert
          /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
          final resultList = result.getOrElse(() => []);
          expect(resultList, testTvShowList);
        });

    test('should return ServerFailure when call to data source is unsuccessful',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenThrow(ServerException());
          // act
          final result = await repository.searchTvShows(tQuery);
          // assert
          expect(result, Left(ServerFailure('')));
        });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
            () async {
          // arrange
          when(mockRemoteDataSource.searchTvShows(tQuery))
              .thenThrow(SocketException('Failed to connect to the network'));
          // act
          final result = await repository.searchTvShows(tQuery);
          // assert
          expect(
              result, Left(ConnectionFailure('Failed to connect to the network')));
        });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertTvShowWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowWatchlist(testTvShowTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeTvShowWatchlist(testTvShowTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeTvShowWatchlist(testTvShowDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      const tvId = 1;
      when(mockLocalDataSource.getTvShowById(tvId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tvId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv shows', () {
    test('should return list of TV Shows', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvShows())
          .thenAnswer((_) async => testTvShowTableList);
      // act
      final result = await repository.getWatchlistTvShows();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, testWatchlistTvShow);
    });
  });
}
