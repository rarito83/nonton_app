// Mocks generated by Mockito 5.0.15 from annotations
// in nonton_app/test/presentation/pages/movie/watchlist_movie_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i6;
import 'dart:ui' as _i7;

import 'package:nonton_app/common/state_enum.dart' as _i5;
import 'package:nonton_app/domain/entities/movie.dart' as _i4;
import 'package:nonton_app/domain/usecases/movie/get_watchlist_movies.dart'
as _i2;
import 'package:nonton_app/presentation/providers/movie/watchlist_movies_notifier.dart'
as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetWatchlistMovies_0 extends _i1.Fake
    implements _i2.GetWatchlistMovies {}

/// A class which mocks [WatchlistMovieNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockWatchlistMovieNotifier extends _i1.Mock
    implements _i3.WatchlistMovieNotifier {
  MockWatchlistMovieNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetWatchlistMovies get getWatchlistMovies =>
      (super.noSuchMethod(Invocation.getter(#getWatchlistMovies),
          returnValue: _FakeGetWatchlistMovies_0()) as _i2.GetWatchlistMovies);
  @override
  List<_i4.Movie> get watchlistMovies =>
      (super.noSuchMethod(Invocation.getter(#watchlistMovies),
          returnValue: <_i4.Movie>[]) as List<_i4.Movie>);
  @override
  _i5.RequestState get watchlistState =>
      (super.noSuchMethod(Invocation.getter(#watchlistState),
          returnValue: _i5.RequestState.empty) as _i5.RequestState);
  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
      as String);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
      as bool);
  @override
  _i6.Future<void> fetchWatchlistMovies() =>
      (super.noSuchMethod(Invocation.method(#fetchWatchlistMovies, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i6.Future<void>);
  @override
  void addListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(_i7.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void dispose() => super.noSuchMethod(Invocation.method(#dispose, []),
      returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
  @override
  String toString() => super.toString();
}