import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/utils/routes.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:tv/presentation/bloc/airing_today/airing_today_bloc.dart';
import 'package:tv/presentation/bloc/popular/popular_tv_bloc.dart';
import 'package:tv/presentation/bloc/top_rated/top_rated_tv_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeTvPage extends StatefulWidget {
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  State<HomeTvPage> createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<AiringTodayBloc>().add(OnAiringToday());
      context.read<PopularTvBloc>().add(OnPopularTv());
      context.read<TopRatedTvBloc>().add(OnTopRatedTv());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSubHeading(
              title: 'Airin Today',
              onTap: () => Navigator.pushNamed(context, AIRING_TODAY_ROUTE),
            ),
            BlocBuilder<AiringTodayBloc, AiringTodayState>(
                builder: (context, state) {
              if (state is AiringTodayLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is AiringTodayHasData) {
                return TvList(
                  listTv: state.listAiringToday,
                );
              } else if (state is AiringTodayError) {
                return const Text('Failed');
              } else {
                return const SizedBox();
              }
            }),
            _buildSubHeading(
              title: 'Popular',
              onTap: () =>
                  Navigator.pushNamed(context, POPULAR_TV_ROUTE ),
            ),
            BlocBuilder<PopularTvBloc, PopularTvState>(
                builder: (context, state) {
              if (state is PopularTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is PopularTvHasData) {
                return TvList(
                  listTv: state.listPopularTv,
                );
              } else if (state is PopularTvError) {
                return const Text('Failed');
              } else {
                return const SizedBox();
              }
            }),
            _buildSubHeading(
              title: 'Top Rated',
              onTap: () =>
                  Navigator.pushNamed(context, TOP_RATED_TV_ROUTE ),
            ),
            BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                builder: (context, state) {
              if (state is TopRatedTvLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TopRatedTvHasData) {
                return TvList(
                  listTv: state.listTopRatedTv,
                );
              } else if (state is TopRatedTvError) {
                return const Text('Failed');
              } else {
                return const SizedBox();
              }
            }),
          ],
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        )
      ],
    );
  }
}

class TvList extends StatelessWidget {
  final List<Tv> listTv;
  const TvList({Key? key, required this.listTv}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tv = listTv[index];
          return Container(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, TV_DETAIL_ROUTE,
                    arguments: tv.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: listTv.length,
      ),
    );
  }
}
