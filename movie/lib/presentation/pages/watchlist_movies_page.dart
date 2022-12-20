import 'package:core/utils/utils.dart';


import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/widgets/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/watchlist/watchlist_movies_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  

  const WatchlistMoviesPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      context.read<WatchlistMovieBloc>().add(OnWatchlistMovies());
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMovieBloc>().add(OnWatchlistMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watchlist Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc,WatchlistMoviesState>(
          builder: (context, state) {
            if (state is WatchlistMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistMoviesHasData ) {
              if(state.listWatchlist.isNotEmpty){
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.listWatchlist[index];
                  return MovieCard(movie);
                },
                itemCount: state.listWatchlist.length,
              ); }
              else {
                return const EmptyWidget();
              }

            }else if (state is WatchlistMoviesError) {
                return const Text('Failed');
              } else {
                return const EmptyWidget();
              }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
