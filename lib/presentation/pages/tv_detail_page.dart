import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-detail-page';
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
      Provider.of<TvDetailNotfier>(context, listen: false)
        ..fetchTvDetail(widget.id)
        ..fetchTvRecommendations(widget.id)
        ..loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvDetailNotfier>(builder: (context, provider, child) {
        if (provider.state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (provider.state == RequestState.Loaded) {
          return SafeArea(child: DetailContent(tv: provider.tv, isAddedToWatchlist: provider.isAddedToWatchlist,)) ;
        } else {
          return Center(
            child: Text(provider.message),
          );
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
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 56.0),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                decoration: BoxDecoration(
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
                                if(!isAddedToWatchlist){
                                  await Provider.of<TvDetailNotfier>(context,listen: false).addWatchlist(tv);
                                } else {
                                  await Provider.of<TvDetailNotfier>(context, listen: false).removeWatchlist(tv);
                                }
                                final message = Provider.of<TvDetailNotfier>(context,listen: false).messageWatchlist;
                                if(message == TvDetailNotfier.watchlistAddSuccessMessage || message == TvDetailNotfier.watchlistRemoveSuccessMessage){
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
                                  isAddedToWatchlist ? Icon(Icons.checklist) : Icon(Icons.add), Text('Watchlist')],
                              ),
                            ),
                            Text(_showGenres(tv.genres)),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tv.voteAverage / 2,
                                  itemCount: 5,
                                  itemSize: 24,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                ),
                                Text('${tv.voteAverage}')
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(tv.overview),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Seasons',
                              style: kHeading6,
                            ),
                            Container(
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
                                    padding: EdgeInsets.all(8.0),
                                    margin: EdgeInsets.only(right: 8.0),
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
                                            SizedBox(width: 3,),
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
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TvDetailNotfier>(
                                builder: (context, recommen, child) {
                              if (recommen.recommendationState ==
                                  RequestState.Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (recommen.recommendationState ==
                                  RequestState.Loaded) {
                                return Container(
                                  height: 150.0,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final tv =
                                          recommen.listTvRecommentations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  TvDetailPage.ROUTE_NAME,
                                                  arguments: tv.id);
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    '$BASE_IMAGE_URL${tv.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            )),
                                      );
                                    },
                                    itemCount:
                                        recommen.listTvRecommentations.length,
                                  ),
                                );
                              } else if (recommen.recommendationState ==
                                  RequestState.Error) {
                                return Text('Failed');
                              } else {
                                return Container();
                              }
                            }),
                             SizedBox(
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
              icon: Icon(Icons.arrow_back),
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}
