// ignore_for_file: depend_on_referenced_packages

import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/top_rated/top_rated_movies_bloc.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';


class MockTopRatedMoviesBloc
    extends MockBloc<TopRatedMoviesEvent, TopRatedMoviesState>
    implements TopRatedMoviesBloc {}

class TopRatedMoviesEventFake extends Fake implements TopRatedMoviesEvent {}

class TopRatedMoviesStateFake extends Fake implements TopRatedMoviesState {}

void main() {
  late MockTopRatedMoviesBloc mockTopRatedMoviesBloc;

  setUpAll(() {
    registerFallbackValue(TopRatedMoviesEventFake);
    registerFallbackValue(TopRatedMoviesStateFake);
  });

  setUp(() {
    mockTopRatedMoviesBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockTopRatedMoviesBloc,
      child: const MaterialApp(
        home: TopRatedMoviesPage(),
      ),
    );
  }

  group('Top Rated Movies Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(TopRatedMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget());

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockTopRatedMoviesBloc.state)
          .thenReturn(const TopRatedMoviesHasData(<Movie>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget());

      expect(listViewFinder, findsOneWidget);
    });

     testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedMoviesBloc.state).thenReturn(const TopRatedMoviesError('Server Failure'));
    

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(textFinder, findsOneWidget);
  });

  });
}
