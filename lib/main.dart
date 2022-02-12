import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/common/utils.dart';
import 'package:nonton_app/injection.dart' as di;
import 'package:nonton_app/presentation/pages/about_page.dart';
import 'package:nonton_app/presentation/pages/home_page.dart';
import 'package:nonton_app/presentation/pages/movie/movie_detail_page.dart';
import 'package:nonton_app/presentation/pages/movie/popular_movies_page.dart';
import 'package:nonton_app/presentation/pages/movie/top_rated_movies_page.dart';
import 'package:nonton_app/presentation/pages/search_page.dart';
import 'package:nonton_app/presentation/pages/tvshow/popular_tv_shows_page.dart';
import 'package:nonton_app/presentation/pages/tvshow/top_rated_tv_shows_page.dart';
import 'package:nonton_app/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:nonton_app/presentation/pages/watchlist_page.dart';
import 'package:nonton_app/presentation/providers/home_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/movie_detail_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/movie_list_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/popular_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/top_rated_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/movie/watchlist_movies_notifier.dart';
import 'package:nonton_app/presentation/providers/search_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/popular_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/top_rated_tv_shows_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_detail_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_list_notifier.dart';
import 'package:nonton_app/presentation/providers/tvshow/watchlist_tv_shows_notifier.dart';
import 'package:provider/provider.dart';

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
          create: (_) => di.locator<HomeNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvShowDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvShowsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvShowNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvShowsNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Nonton App',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case PopularMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => const WatchlistPage());
            case PopularTvShowsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => PopularTvShowsPage());
            case TopRatedTvShowsPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TopRatedTvShowsPage());
            case TvShowDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvShowDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              final drawerItem = settings.arguments as DrawerItem;
              return MaterialPageRoute(
                builder: (_) => SearchPage(
                  drawerItem: drawerItem,
                ),
              );
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found :('),
                    ),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
