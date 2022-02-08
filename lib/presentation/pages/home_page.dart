import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/presentation/pages/about_page.dart';
import 'package:nonton_app/presentation/pages/movie/home_movie_page.dart';
import 'package:nonton_app/presentation/pages/search_page.dart';
import 'package:nonton_app/presentation/pages/tvshow/home_tv_show_page.dart';
import 'package:nonton_app/presentation/pages/watchlist_page.dart';
import 'package:nonton_app/presentation/providers/home_notifier.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  static const ROUTE_NAME = '/home';

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeNotifier>(builder: (ctx, data, child) {
      final activeDrawerItem = data.selectedDrawerItem;

      return Scaffold(
        key: _globalKey,
        drawer: _buildDrawer(ctx, (DrawerItem newSelectedItem) {
          data.setSelectedDrawerItem(newSelectedItem);
        }, activeDrawerItem),
        appBar: _buildAppBar(ctx, activeDrawerItem),
        body: _buildBody(ctx, activeDrawerItem),
      );
    });
  }

  Widget _buildBody(BuildContext context, DrawerItem seletedDrawerItem) {
    if (seletedDrawerItem == DrawerItem.movie) {
      return HomeMoviePage();
    } else if (seletedDrawerItem == DrawerItem.tvShow) {
      return HomeTvShowPage();
    }
    return Container();
  }

  AppBar _buildAppBar(
    BuildContext context,
    DrawerItem activeDrawerItem,
  ) =>
      AppBar(
        title: const Text('Nonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SearchPage.ROUTE_NAME,
                arguments: activeDrawerItem,
              );
            },
            icon: const Icon(Icons.search),
          )
        ],
      );

  Drawer _buildDrawer(
    BuildContext context,
    Function(DrawerItem) itemCallback,
    DrawerItem activeDrawerItem,
  ) =>
      Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Nonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              tileColor:
                  activeDrawerItem == DrawerItem.movie ? kDavysGrey : kGrey,
              leading: const Icon(Icons.movie_creation_outlined),
              title: const Text('Movies'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(DrawerItem.movie);
              },
            ),
            ListTile(
              tileColor:
                  activeDrawerItem == DrawerItem.tvShow ? kDavysGrey : kGrey,
              leading: const Icon(Icons.live_tv_rounded),
              title: const Text('Tv Shows'),
              onTap: () {
                Navigator.pop(context);
                itemCallback(DrawerItem.tvShow);
              },
            ),
            ListTile(
              leading: const Icon(Icons.save_alt),
              title: const Text('Watchlist'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: const Icon(Icons.info_outline),
              title: const Text('About'),
            ),
          ],
        ),
      );
}
