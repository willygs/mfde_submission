

import '../../utils/state_enum.dart';
import '../../presentation/provider/airing_today_tv_notifier.dart';
import '../../presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AiringTodayTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/airing-today-tv';
  const AiringTodayTvPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayTvPage> createState() => _AiringTodayTvPageState();
}

class _AiringTodayTvPageState extends State<AiringTodayTvPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<AiringTodayTvNotifier>(context, listen: false)
            .fetchAiringTodayTv());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Airing Today TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<AiringTodayTvNotifier>(builder: (context, data, child) {
          final state = data.state;

          if (state == RequestState.Loading) {
            return Center(
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
              key: Key('error_message'),
              child: Text(data.message),
            );
          }
        }),
      ),
    );
  }
}