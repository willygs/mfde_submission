import 'package:core/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/airing_today/airing_today_bloc.dart';

class AiringTodayTvPage extends StatefulWidget {
  const AiringTodayTvPage({Key? key}) : super(key: key);

  @override
  State<AiringTodayTvPage> createState() => _AiringTodayTvPageState();
}

class _AiringTodayTvPageState extends State<AiringTodayTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AiringTodayBloc>().add(OnAiringToday());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Airing Today TV'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<AiringTodayBloc, AiringTodayState>(
            builder: (context, state) {
          if (state is AiringTodayLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is AiringTodayHasData) {
            return ListView.builder(
              itemBuilder: (context, index) {
                final tv = state.listAiringToday[index];
                return TvCard(
                  tv: tv,
                );
              },
              itemCount: state.listAiringToday.length,
            );
          } else if (state is AiringTodayError) {
            return Center(
              key: const Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    );
  }
}
