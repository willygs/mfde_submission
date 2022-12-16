import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_search_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                Provider.of<TvSearchNotifier>(context, listen: false)
                    .fetchSearchTv(query);
              },
              decoration: InputDecoration(
                  hintText: 'Search name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            Consumer<TvSearchNotifier>(builder: (context, data, child) {
              final state = data.state;

              if (state == RequestState.Loading) {
                print(state);
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state == RequestState.Loaded) {
                print(state);
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = data.listTv[index];
                      return TvCard(
                        tv: tv,
                      );
                    },
                    itemCount: data.listTv.length,
                  ),
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}
