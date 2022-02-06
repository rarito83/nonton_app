import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';
import 'package:nonton_app/domain/entities/movie.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';

import '../../common/constants.dart';

class CardSearchContent extends StatelessWidget {
  final Movie? movie;
  final TvShow? tvShow;
  final DrawerItem drawerItem;
  final String routeName;

  const CardSearchContent({
    required this.drawerItem,
    this.movie,
    this.tvShow,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Material(
        color: kRichBlack,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              routeName,
              arguments: _getId(),
            );
          },
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Card(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 16 + 80 + 16,
                    bottom: 8,
                    right: 8,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _getTitle() ?? NOT_STRING_REPLACEMENT,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kHeading6,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getOverview() ?? NOT_STRING_REPLACEMENT,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: ClipRRect(
                  child: CachedNetworkImage(
                    imageUrl: "$BASE_IMAGE_URL${_getPosterPath()}",
                    width: 80,
                    placeholder: (context, url) => const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _getId() =>
      drawerItem == DrawerItem.Movie ? movie?.id as int : tvShow?.id as int;

  String? _getTitle() =>
      drawerItem == DrawerItem.Movie ? movie?.title : tvShow?.name;

  String _getPosterPath() => drawerItem == DrawerItem.Movie
      ? movie?.posterPath as String
      : tvShow?.posterPath as String;

  String? _getOverview() =>
      drawerItem == DrawerItem.Movie ? movie?.overview : tvShow?.overview;
}
