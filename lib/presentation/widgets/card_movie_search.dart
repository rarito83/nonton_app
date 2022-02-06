import 'package:flutter/material.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/domain/entities/movie.dart';
import 'package:nonton_app/presentation/widgets/card_search_content.dart';

import '../pages/movie/movie_detail_page.dart';

class CardMovieSearch extends StatelessWidget {
  final List<Movie> searchMovieResult;

  CardMovieSearch(this.searchMovieResult);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final movie = searchMovieResult[index];
          return CardSearchContent(
            movie: movie,
            drawerItem: DrawerItem.Movie,
            routeName: MovieDetailPage.ROUTE_NAME,
          );
        },
        itemCount: searchMovieResult.length,
      ),
    );
  }
}
