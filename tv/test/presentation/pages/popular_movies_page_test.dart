import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:movie/presentation/bloc/popular_movies/popular_movies_bloc.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';

class MockPopularMoviesBloc
    extends MockBloc<PopularMoviesEvent, PopularMoviesState>
    implements PopularMoviesBloc {}

class PopularMoviesEventFake extends Fake implements PopularMoviesEvent {}

class PopularMoviesStateFake extends Fake implements PopularMoviesState {}

void main() {
  late MockPopularMoviesBloc mockPopularMoviesBloc;

  setUpAll(() {
    registerFallbackValue(PopularMoviesEventFake);
    registerFallbackValue(PopularMoviesStateFake);
  });

  setUp(() {
    mockPopularMoviesBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockPopularMoviesBloc,
      child: const MaterialApp(
        home: PopularMoviesPage(),
      ),
    );
  }

  group('Poular Movies Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(PopularMoviesLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget());

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockPopularMoviesBloc.state)
          .thenReturn(const PopularMoviesHasData(<Movie>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget());

      expect(listViewFinder, findsOneWidget);
    });

     testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularMoviesBloc.state).thenReturn(const PopularMoviesError('Server Failure'));
    

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(textFinder, findsOneWidget);
  });

  });
}
