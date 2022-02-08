// Mocks generated by Mockito 5.0.15 from annotations
// in nonton_app/test/presentation/pages/tvshow/tv_show_detail_page_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;
import 'dart:ui' as _i12;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nonton_app/common/state_enum.dart' as _i9;
import 'package:nonton_app/domain/entities/tv_show.dart' as _i10;
import 'package:nonton_app/domain/entities/tv_show_detail.dart' as _i7;
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_detail.dart'
    as _i2;
import 'package:nonton_app/domain/usecases/tvshow/get_tv_show_recommendation.dart'
    as _i3;
import 'package:nonton_app/domain/usecases/tvshow/get_watchlist_tv_show_status.dart'
    as _i4;
import 'package:nonton_app/domain/usecases/tvshow/remove_tv_show_watchlist.dart'
    as _i6;
import 'package:nonton_app/domain/usecases/tvshow/save_tv_show_watchlist.dart'
    as _i5;
import 'package:nonton_app/presentation/providers/tvshow/tv_show_detail_notifier.dart'
    as _i8;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeGetTvShowDetail_0 extends _i1.Fake implements _i2.GetTvShowDetail {}

class _FakeGetTvShowRecommendations_1 extends _i1.Fake
    implements _i3.GetTvShowRecommendation {}

class _FakeGetTvShowWatchlistStatus_2 extends _i1.Fake
    implements _i4.GetWatchlistTvShowStatus {}

class _FakeSaveTvShowWatchlist_3 extends _i1.Fake
    implements _i5.SaveTvShowWatchlist {}

class _FakeRemoveTvShowWatchlist_4 extends _i1.Fake
    implements _i6.RemoveTvShowWatchlist {}

class _FakeTvShowDetail_5 extends _i1.Fake implements _i7.TvShowDetail {}

/// A class which mocks [TvShowDetailNotifier].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvShowDetailNotifier extends _i1.Mock
    implements _i8.TvShowDetailNotifier {
  MockTvShowDetailNotifier() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetTvShowDetail get getTvShowDetail =>
      (super.noSuchMethod(Invocation.getter(#getTvShowDetail),
          returnValue: _FakeGetTvShowDetail_0()) as _i2.GetTvShowDetail);

  @override
  _i3.GetTvShowRecommendation get getTvShowRecommendations =>
      (super.noSuchMethod(Invocation.getter(#getTvShowRecommendations),
              returnValue: _FakeGetTvShowRecommendations_1())
          as _i3.GetTvShowRecommendation);

  @override
  _i4.GetWatchlistTvShowStatus get getWatchlistTvShowStatus =>
      (super.noSuchMethod(Invocation.getter(#getTvShowWatchlistStatus),
              returnValue: _FakeGetTvShowWatchlistStatus_2())
          as _i4.GetWatchlistTvShowStatus);

  @override
  _i5.SaveTvShowWatchlist get saveTvShowWatchlist => (super.noSuchMethod(
      Invocation.getter(#saveTvShowWatchlist),
      returnValue: _FakeSaveTvShowWatchlist_3()) as _i5.SaveTvShowWatchlist);

  @override
  _i6.RemoveTvShowWatchlist get removeTvShowWatchlist =>
      (super.noSuchMethod(Invocation.getter(#removeTvShowWatchlist),
              returnValue: _FakeRemoveTvShowWatchlist_4())
          as _i6.RemoveTvShowWatchlist);

  @override
  _i7.TvShowDetail get tvShowDetail =>
      (super.noSuchMethod(Invocation.getter(#tvShowDetail),
          returnValue: _FakeTvShowDetail_5()) as _i7.TvShowDetail);

  @override
  _i9.RequestState get tvShowState =>
      (super.noSuchMethod(Invocation.getter(#tvShowState),
          returnValue: _i9.RequestState.empty) as _i9.RequestState);

  @override
  List<_i10.TvShow> get tvShowRecommendations =>
      (super.noSuchMethod(Invocation.getter(#tvShowRecommendations),
          returnValue: <_i10.TvShow>[]) as List<_i10.TvShow>);

  @override
  _i9.RequestState get recommendationState =>
      (super.noSuchMethod(Invocation.getter(#recommendationState),
          returnValue: _i9.RequestState.empty) as _i9.RequestState);

  @override
  String get message =>
      (super.noSuchMethod(Invocation.getter(#message), returnValue: '')
          as String);

  @override
  bool get isAddedToWatchlist =>
      (super.noSuchMethod(Invocation.getter(#isAddedToWatchlist),
          returnValue: false) as bool);

  @override
  String get watchlistMessage =>
      (super.noSuchMethod(Invocation.getter(#watchlistMessage), returnValue: '')
          as String);

  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);

  @override
  _i11.Future<void> fetchTvShowDetail(int? id) => (super.noSuchMethod(
      Invocation.method(#fetchTvShowDetail, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);

  @override
  _i11.Future<void> addWatchlist(_i7.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#addWatchlist, [tvShow]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);

  @override
  _i11.Future<void> removeWatchlist(_i7.TvShowDetail? tvShow) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvShow]),
              returnValue: Future<void>.value(),
              returnValueForMissingStub: Future<void>.value())
          as _i11.Future<void>);

  @override
  _i11.Future<void> loadWatchlistStatus(int? id) => (super.noSuchMethod(
      Invocation.method(#loadWatchlistStatus, [id]),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future<void>.value()) as _i11.Future<void>);

  @override
  void addListener(_i12.VoidCallback? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);

  @override
  void removeListener(_i12.VoidCallback? listener) =>
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
