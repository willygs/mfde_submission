

import 'package:core/utils/state_enum.dart';
import 'package:core/utils/utils.dart';

import '../../presentation/provider/watchlist_tv_notifier.dart';
import '../../presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<WatchlistTvNotifier>(context, listen:  false).fetchWatchlistTv()
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);

  }

  void didPopNext() {
     Provider.of<WatchlistTvNotifier>(context, listen:  false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist TV'),
      ),
     body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<WatchlistTvNotifier>(builder: (context, data, child) {
          final state = data.state;

          if (state == RequestState.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
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

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}