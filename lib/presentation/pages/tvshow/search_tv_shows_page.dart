import 'package:flutter/material.dart';
import 'package:nonton_app/common/constants.dart';
import 'package:nonton_app/common/state_enum.dart';
import 'package:nonton_app/presentation/providers/tvshow/tv_show_search_notifier.dart';
import 'package:nonton_app/presentation/widgets/tv_show_card.dart';
import 'package:provider/provider.dart';

class SearchTvShowsPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';

  @override
  Widget build(BuildContext context) {
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
                Provider.of<TvShowSearchNotifier>(context, listen: false)
                    .fetchTvShowSearch(query);
              },
              decoration: InputDecoration(
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
            Consumer<TvShowSearchNotifier>(
              builder: (context, data, child) {
                if (data.state == RequestState.loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (data.state == RequestState.loaded) {
                  final result = data.searchResult;
                  return Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemBuilder: (context, index) {
                        final tv = data.searchResult[index];
                        return TvShowCard(tv);
                      },
                      itemCount: result.length,
                    ),
                  );
                } else {
                  return Expanded(
                    child: Container(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
