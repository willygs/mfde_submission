

import 'package:core/utils/state_enum.dart';

import '../../presentation/provider/popular_tv_notifier.dart';
import '../../presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PopularTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-tv';
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {

  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      Provider.of<PopularTvNotifier>(context,listen: false).fetchPopularTv()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<PopularTvNotifier>(
          builder: (context, data, child) {
            final state = data.state;

           
            if(state==RequestState.Loading){
              
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state == RequestState.Loaded){
              
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tv = data.listTv[index];
                  return TvCard(tv: tv,);
                },
                itemCount: data.listTv.length,
              );
            } else {
              return Center(
                key: const Key('error_message'),
                child: Text(data.message),
              );
            }
          }
          
        
        ),
      ),
    );
  }
}