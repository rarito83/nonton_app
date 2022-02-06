import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/presentation/providers/search_notifier.dart';
import 'package:nonton_app/presentation/widgets/card_movie_search.dart';
import 'package:nonton_app/presentation/widgets/card_tv_show_search.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  SearchPage({
    Key? key,
    required this.drawerItem,
  }) : super(key: key);

  final DrawerItem drawerItem;
  late bool _isAlreadySearched = false;
  late String _title;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchNotifier>(context);
    _title = drawerItem == DrawerItem.Movie ? "Movie" : "TV Show";

    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<SearchNotifier>(context, listen: false)
                    .fetchMovieSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            _buildSearch(),
          ],
        ),
      ),
    );
  }

  Widget _buildSearch() {
    return Consumer<SearchNotifier>(builder: (context, data, child) {
      if (data.state == RequestState.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (data.state == RequestState.loaded && _isAlreadySearched) {
        drawerItem == DrawerItem.Movie
            ? CardMovieSearch(data.searchMovieResult)
            : CardTvShowSearch(data.searchTvShowsResult);
      }
      return Container();
    });
  }
}
