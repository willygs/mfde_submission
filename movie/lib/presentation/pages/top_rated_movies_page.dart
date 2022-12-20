
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  

  const TopRatedMoviesPage({super.key});

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
       context.read<TopRatedMoviesBloc>().add(OnTopRatedMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMoviesBloc,TopRatedMoviesState>(
          builder: (context, state) {
            if (state is TopRatedMoviesLoading ) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is TopRatedMoviesHasData ) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.listTopRated[index];
                  return MovieCard(movie);
                },
                itemCount: state.listTopRated.length,
              );
            } else if (state is TopRatedMoviesError) {
              return const Text('Failed');
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}
