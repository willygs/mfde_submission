import 'package:core/utils/state_enum.dart';
import 'package:core/widgets/not_found_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/presentation/bloc/search_tv_bloc.dart';

import '../../presentation/provider/tv_search_notifier.dart';
import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:core/styles/text_styles.dart';

class SearchTvPage extends StatelessWidget {
  static const ROUTE_NAME = '/search-tv';
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (query) {
                context.read<SearchTvBloc>().add(OnQueryChanged(query));
              },
              onSubmitted: (query) {
                Provider.of<TvSearchNotifier>(context, listen: false)
                    .fetchSearchTv(query);
              },
              decoration: const InputDecoration(
                  hintText: 'Search name',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder()),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Text(
              'Search Result',
              style: kHeading6,
            ),
            BlocBuilder<SearchTvBloc,SearchTvState>(
              builder: (context, state) {
             

              if (state is SearchTvLoading) {
               
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvHasData ) {
                final result = state.result;
                if(result.isNotEmpty){
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      final tv = result[index];
                      return TvCard(
                        tv: tv,
                      );
                    },
                    itemCount: result.length,
                  ),
                ); 
                } else{
                  return const NotFoundWidget();
                }
                
              } else if(state is SearchTvError){
                return Expanded(
                    child: Center(
                      child: Text(state.message),
                    ),
                  );
              } else {
                return Expanded(
                    child: Container(),
                  );
              }
            }),
          ],
        ),
      ),
    );
  }
}
