import '../../presentation/provider/top_rated_tv_notifier.dart';
import '../../presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/state_enum.dart';

class TopRatedTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-tv';

  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TopRatedTvNotifier>(context, listen: false)
            .fetchTopRatedTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TopRatedTvNotifier>(builder: (context, data, child) {
          final state = data.state;

          if (state == RequestState.Loading) {
            return const Center(
              child:  CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = data.listTv[index];
                return TvCard(
                  tv: tv,
                );
              },
              itemCount: data.listTv.length,
            );
          } else {
            return Center(
              key: const Key('error_message'),
              child: Text(data.message),
            );
          }
        }),
      ),
    );
  }
}