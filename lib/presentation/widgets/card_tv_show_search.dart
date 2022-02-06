import 'package:flutter/material.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:nonton_app/presentation/widgets/card_search_content.dart';

class CardTvShowSearch extends StatelessWidget {
  final List<TvShow> searchTvShowsResult;

  CardTvShowSearch(this.searchTvShowsResult);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          final tvShow = searchTvShowsResult[index];
          return CardSearchContent(
            tvShow: tvShow,
            drawerItem: DrawerItem.TVShow,
            routeName: TvShowDetailPage.ROUTE_NAME,
          );
        },
        itemCount: searchTvShowsResult.length,
      ),
    );
  }
}
