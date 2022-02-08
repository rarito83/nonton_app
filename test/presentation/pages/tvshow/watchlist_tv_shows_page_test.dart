import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/presentation/pages/tvshow/watchlist_tv_show_page.dart';
import 'package:nonton_app/presentation/providers/tvshow/watchlist_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/widgets/tv_show_card.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'watchlist_tv_shows_page_test.mocks.dart';

@GenerateMocks([WatchlistTvShowsNotifier])
void main() {
  late MockWatchlistTvShowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistTvShowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistTvShowsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist tv shows', () {
    testWidgets('watchlist tv shows should display',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistTvShows).thenReturn(testTvShowList);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvShowPage()));

      expect(find.byType(TvShowCard), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistTvShows).thenReturn(<TvShow>[]);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvShowPage()));

      expect(find.text(WATCHLIST_TV_SHOW_EMPTY_MESSAGE), findsOneWidget);
    });

    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

      await tester.pumpWidget(_makeTestableWidget(WatchlistTvShowPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
