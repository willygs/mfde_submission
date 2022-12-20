import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';

class TopRatedTvPage extends StatefulWidget {
  const TopRatedTvPage({Key? key}) : super(key: key);

  @override
  State<TopRatedTvPage> createState() => _TopRatedTvPageState();
}

class _TopRatedTvPageState extends State<TopRatedTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TopRatedTvBloc>().add(OnTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
            builder: (context, state) {
          if (state is TopRatedTvLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is TopRatedTvHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.listTopRatedTv[index];
                return TvCard(
                  tv: tv,
                );
              },
              itemCount: state.listTopRatedTv.length,
            );
          } else if (state is TopRatedTvError) {
            return const Text('Failed');
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
