import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/presentation/pages/tvshow/popular_tv_shows_page.dart';
import 'package:nonton_app/presentation/providers/tvshow/popular_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/widgets/tv_show_card.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'popular_tv_shows_page_test.mocks.dart';

@GenerateMocks([PopularTvShowNotifier])
void main() {
  late MockPopularTvShowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockPopularTvShowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<PopularTvShowNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display AppBar when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvShows).thenReturn(testTvShowList);

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Popular Tv Shows'), findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvShows).thenReturn(testTvShowList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(TvShowCard), findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
