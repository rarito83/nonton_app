import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/movie.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/presentation/pages/movie/movie_detail_page.dart';
import 'package:nonton_app/presentation/providers/search_notifier.dart';
import 'package:nonton_app/presentation/widgets/card_search_content.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  SearchPage({
    Key? key,
    required this.drawerItem,
  }) : super(key: key);

  late DrawerItem drawerItem;
  late bool _isSearched = false;
  late String _title;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SearchNotifier>(context);
    _title = drawerItem == DrawerItem.movie ? "Movie" : "Tv Show";

    return Scaffold(
      appBar: AppBar(
        title: Text('Search $_title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                _isSearched = true;
                drawerItem == DrawerItem.movie
                    ? provider.fetchMovieSearch(query)
                    : provider.fetchTvShowSearch(query);
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
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
      } else if (data.state == RequestState.loaded && _isSearched) {
        drawerItem == DrawerItem.movie
            ? _cardMovieSearch(data.searchMovieResult)
            : _cardTvShowSearch(data.searchTvShowsResult);
      }
      return Container();
    });
  }

  Widget _cardMovieSearch(List<Movie> movies) {
    if (movies.isEmpty) return _errorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = movies[index];
          return CardSearchContent(
            movie: movie,
            drawerItem: drawerItem,
            routeName: MovieDetailPage.ROUTE_NAME,
          );
        },
        itemCount: movies.length,
      ),
    );
  }

  Widget _cardTvShowSearch(List<TvShow> tvShows) {
    if (tvShows.isEmpty) return _errorMessage();

    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tv = tvShows[index];
          return CardSearchContent(
            tvShow: tv,
            drawerItem: drawerItem,
            routeName: MovieDetailPage.ROUTE_NAME,
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }

  Widget _errorMessage() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Center(
        child: Text(
          '$_title not found ;(',
          style: kBodyText,
        ),
      ),
    );
  }
}
