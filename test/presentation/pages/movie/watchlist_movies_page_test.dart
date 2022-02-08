import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/movie.dart';
import 'package:nonton_app/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:nonton_app/presentation/providers/movie/watchlist_movies_notifier.dart';
import 'package:nonton_app/presentation/widgets/movie_card_list.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_movies_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieNotifier])
void main() {
  late MockWatchlistMovieNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistMovieNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistMovieNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('watchlist movies', () {
    testWidgets('watchlist movies should display', (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistMovies).thenReturn(testMovieList);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(MovieCard), findsWidgets);
      expect(find.byType(Padding), findsWidgets);
      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('message for feedback should display when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistMovies).thenReturn(<Movie>[]);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(find.text(WATCHLIST_MOVIE_EMPTY_MESSAGE), findsOneWidget);
    });

    testWidgets('loading indicator should display when getting data',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

      await tester.pumpWidget(_makeTestableWidget(WatchlistMoviesPage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
