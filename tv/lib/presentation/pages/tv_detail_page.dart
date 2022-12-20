import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/constants.dart';
import 'package:core/utils/routes.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv/presentation/bloc/detail/detail_tv_bloc.dart';
import 'package:tv/presentation/bloc/recommendation/recommendation_tv_bloc.dart';
import 'package:tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';

class TvDetailPage extends StatefulWidget {
  
  final int id;
  const TvDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvDetailPage> createState() => _TvDetailPageState();
}

class _TvDetailPageState extends State<TvDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
        context.read<DetailTvBloc>().add(OnDetailTv(widget.id));
        context.read<WatchlistTvBloc>().add(OnWatchlistTvStatus(widget.id));
        context.read<RecommendationTvBloc>().add(OnRecommendationTv(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
     final isTvWatchsList =
                context.select<WatchlistTvBloc, bool>((bloc) {
              if (bloc.state is WatchlistTvIsAdded) {
                return (bloc.state as WatchlistTvIsAdded).isAdded;
              }
              return false;
            });
    return Scaffold(
      body: BlocBuilder<DetailTvBloc,DetailTvState>(builder: (context, state) {
        if (state is DetailTvLoading ) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if ( state is DetailTvHasData ) {
          return SafeArea(child: DetailContent(tv: state.tvDetail, isAddedToWatchlist: isTvWatchsList,)) ;
         } else if(state is DetailTvError) {
            return  Text(state.message); 
          } else {
            return const SizedBox();
          }
      }),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvDetail tv;
  final bool isAddedToWatchlist;
  const DetailContent({Key? key, required this.tv, required this.isAddedToWatchlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
          width: size.width,
          placeholder: (context, url) => const Center(
            child:  CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 56.0),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16.0))),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tv.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                              if (!isAddedToWatchlist) {
                                  context.read<WatchlistTvBloc>()
                                    .add(OnWatchlistTvAdd(tv)) ;
                                } else {
                                  context.read<WatchlistTvBloc>()
                                    .add(OnWatchlistTvRemove(tv));
                                  
                                }

                                final state = context.read<WatchlistTvBloc>().state ;
                                String message = "";
                                if(state is WatchlistTvIsAdded){
                                  message = state.isAdded ? watchlistRemoveSuccessMessage : watchlistAddSuccessMessage;
                                } else {
                                  message = isAddedToWatchlist ? watchlistRemoveSuccessMessage : watchlistAddSuccessMessage;
                                }
                              
                               if(message == watchlistAddSuccessMessage ||
                                    message == watchlistRemoveSuccessMessage){
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                                } else {
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(content: Text(message),);
                                  } );
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedToWatchlist ? const Icon(Icons.checklist) : const Icon(Icons.add),const Text('Watchlist')],
                              ),
                            ),
                            Text(_showGenres(tv.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemSize: 24,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(tv.overview),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            SizedBox(
                              height: 80,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  final season = tv.seasons[index];
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: kMikadoYellow, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(8.0)),
                                    width: 150,
                                    height: 80,
                                    padding:const EdgeInsets.all(8.0),
                                    margin:const EdgeInsets.only(right: 8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(child: Text(
                                            '${season.name}' ,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                            ),
                                            const SizedBox(width: 3,),
                                            Text(
                                            'E ${season.episodeCount}'),
                                          ],
                                        ),
                                        
                                        Text(
                                          '${season.overview}',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  );
                                },
                                itemCount: tv.seasons.length,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvBloc,RecommendationTvState>(
                                builder: (context, state) {
                              if (state is RecommendationTvLoading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state is RecommendationTvHasData) {
                                return SizedBox(
                                  height: 150.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv = state.listRecommendationTv[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  TV_DETAIL_ROUTE,
                                                  arguments: tv.id);
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$BASE_IMAGE_URL${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                  const  Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                      const  Icon(Icons.error),
                                              ),
                                            )),
                                      );
                                    },
                                    itemCount:
                                        state.listRecommendationTv.length,
                                  ),
                                );
                              } else if ( state is RecommendationTvError ) {
                                return const Text('Failed');
                              } else {
                                return Container();
                              }
                            }),
                            const SizedBox(
                              height: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            minChildSize: 0.25,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
