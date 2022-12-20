import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/popular/popular_tv_bloc.dart';

class PopularTvPage extends StatefulWidget {
 
  const PopularTvPage({Key? key}) : super(key: key);

  @override
  State<PopularTvPage> createState() => _PopularTvPageState();
}

class _PopularTvPageState extends State<PopularTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<PopularTvBloc>().add(OnPopularTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
            builder: (context, state) {
          if (state is PopularTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is PopularTvHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.listPopularTv[index];
                return TvCard(
                  tv: tv,
                );
              },
              itemCount: state.listPopularTv.length,
            );
          } else if (state is PopularTvError) {
            return const Text('Failed');
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
