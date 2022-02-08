import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'tv_show_detail_page_test.mocks.dart';

@GenerateMocks([TvShowDetailNotifier])
void main() {
  late MockTvShowDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvShowDetailNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvShowDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('All required widget should display',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowDetail).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

        expect(find.text('Watchlist'), findsOneWidget);
        expect(find.text('Overview'), findsOneWidget);
        expect(find.text('Recommendations'), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.byType(RatingBarIndicator), findsOneWidget);
        expect(find.byType(Row), findsWidgets);
        expect(find.byType(Text), findsWidgets);
      });

  testWidgets(
      'Watchlist button should display add icon when tv show not added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowDetail).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);

        final watchlistButtonIcon = find.byIcon(Icons.add);

        await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should dispay check icon when tv show is added to wathclist',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowDetail).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(true);

        final watchlistButtonIcon = find.byIcon(Icons.check);

        await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

        expect(watchlistButtonIcon, findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowDetail).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn(WATCHLIST_ADD_SUCCESS_MESSAGE);

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text(WATCHLIST_ADD_SUCCESS_MESSAGE), findsOneWidget);
      });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
          (WidgetTester tester) async {
        when(mockNotifier.tvShowState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowDetail).thenReturn(testTvShowDetail);
        when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
        when(mockNotifier.tvShowRecommendations).thenReturn(<TvShow>[]);
        when(mockNotifier.isAddedToWatchlist).thenReturn(false);
        when(mockNotifier.watchlistMessage).thenReturn('Failed');

        final watchlistButton = find.byType(ElevatedButton);

        await tester.pumpWidget(_makeTestableWidget(TvShowDetailPage(id: 1)));

        expect(find.byIcon(Icons.add), findsOneWidget);

        await tester.tap(watchlistButton);
        await tester.pump();

        expect(find.byType(AlertDialog), findsOneWidget);
        expect(find.text('Failed'), findsOneWidget);
      });
}
