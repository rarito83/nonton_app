import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/utils.dart';
import 'package:nonton_app/presentation/pages/about_page.dart';
import 'package:nonton_app/presentation/pages/movie/home_movie_page.dart';
import 'package:nonton_app/presentation/pages/movie/movie_detail_page.dart';
import 'package:nonton_app/presentation/pages/movie/popular_movies_page.dart';
import 'package:nonton_app/presentation/pages/movie/search_page.dart';
import 'package:nonton_app/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:nonton_app/presentation/pages/movie/watchlist_movies_page.dart';
import 'package:nonton_app/presentation/providers/movie/movie_detail_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/movie_list_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/movie_search_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/popular_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/top_rated_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/watchlist_movies_notifier.dart';
import 'package:provider/provider.dart';
import 'package:nonton_app/injection.dart' as di;

void main() {
  di.init();
  runApp(NontonApp());
}

class NontonApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return const Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
