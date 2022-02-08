import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/failure.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/usecases/movie/search_movies.dart';
import 'package:nonton_app/domain/usecases/tvshow/search_tv_shows.dart';
import 'package:nonton_app/presentation/providers/search_notifier.dart';

import '../dummy_data/dummy_objects.dart';
import '../dummy_data/dummy_objects_tv.dart';
import 'search_notifier_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTvShows])
void main() {
  late SearchNotifier provider;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTvShows mockSearchTvShows;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockSearchMovies = MockSearchMovies();
    mockSearchTvShows = MockSearchTvShows();
    provider = SearchNotifier(
        searchMovies: mockSearchMovies, searchTvShows: mockSearchTvShows)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final testQueryMovie = 'spiderman';
  final testQueryTvShow = 'squid game';

  group('search movies', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchMovies.execute(testQueryMovie))
          .thenAnswer((_) async => Right(testMovieList));
      // act
      provider.fetchMovieSearch(testQueryMovie);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchMovies.execute(testQueryMovie))
          .thenAnswer((_) async => Right(testMovieList));
      // act
      await provider.fetchMovieSearch(testQueryMovie);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchMovieResult, testMovieList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchMovies.execute(testQueryMovie))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchMovieSearch(testQueryMovie);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('search tv shows', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      provider.fetchTvShowSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.loading);
    });

    test('should change search result data when data is gotten successfully',
        () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => Right(testTvShowList));
      // act
      await provider.fetchTvShowSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.loaded);
      expect(provider.searchTvShowsResult, testQueryTvShow);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTvShows.execute(testQueryTvShow))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvShowSearch(testQueryTvShow);
      // assert
      expect(provider.state, RequestState.error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
