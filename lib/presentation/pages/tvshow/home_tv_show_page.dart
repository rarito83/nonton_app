import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/domain/entities/tv_show.dart';
import 'package:nonton_app/presentation/pages/tvshow/popular_tv_shows_page.dart';
import 'package:nonton_app/presentation/pages/tvshow/top_rated_tv_shows_page.dart';
import 'package:nonton_app/presentation/pages/tvshow/tv_show_detail_page.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_list_notifier.dart';
import 'package:provider/provider.dart';

class HomeTvShowPage extends StatefulWidget {
  static const ROUTE_NAME = '/home-tvshow';

  @override
  _HomeTvShowPageState createState() => _HomeTvShowPageState();
}

class _HomeTvShowPageState extends State<HomeTvShowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => Provider.of<TvShowListNotifier>(context, listen: false)
          ..fetchNowPlayingTvShows()
          ..fetchPopularTvShows()
          ..fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Now Playing',
              style: kHeading6,
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.nowPlayingTvShowState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvShowList(data.nowPlayingTvShows);
              } else {
                return const Text(FAILED_TO_FETCH_DATA_MESSAGE);
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, PopularTvShowsPage.ROUTE_NAME),
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.popularTvShowState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvShowList(data.popularTvShows);
              } else {
                return const Text(FAILED_TO_FETCH_DATA_MESSAGE);
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TopRatedTvShowsPage.ROUTE_NAME),
            ),
            Consumer<TvShowListNotifier>(builder: (context, data, child) {
              final state = data.topRatedTvShowsState;
              if (state == RequestState.loading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.loaded) {
                return TvShowList(data.topRatedTvShows);
              } else {
                return const Text(FAILED_TO_FETCH_DATA_MESSAGE);
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TvShowList extends StatelessWidget {
  final List<TvShow> tvShows;

  TvShowList(this.tvShows);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = tvShows[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvShowDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvShows.length,
      ),
    );
  }
}
