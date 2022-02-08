import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/presentation/pages/tvshow/top_rated_tv_shows_page.dart';
import 'package:nonton_app/presentation/providers/tvshow/top_rated_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/widgets/tv_show_card.dart';
import 'package:provider/provider.dart';

import '../../../dummy_data/dummy_objects_tv.dart';
import 'top_rated_tv_shows_page_test.mocks.dart';

@GenerateMocks([TopRatedTvShowsNotifier])
void main() {
  late MockTopRatedTvShowNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvShowNotifier();
  });

  Widget _makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvShowsNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display AppBar when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvShows).thenReturn(testTvShowList);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.text('Top Rated Tv Shows'), findsOneWidget);
  });

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loading);

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.loaded);
    when(mockNotifier.tvShows).thenReturn(testTvShowList);

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

    expect(listViewFinder, findsOneWidget);
    expect(find.byType(TvShowCard), findsWidgets);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(mockNotifier.state).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvShowsPage()));

    expect(textFinder, findsOneWidget);
  });
}
