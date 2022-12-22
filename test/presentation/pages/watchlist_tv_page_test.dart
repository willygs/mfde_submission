import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/watchlist/watchlist_tv_bloc.dart';
import 'package:tv/presentation/pages/watchlist_tv_page.dart';

class MockWatchlistTvBloc
    extends MockBloc<WatchlistTvEvent, WatchlistTvState>
    implements WatchlistTvBloc {}

class WatchlistTvEventFake extends Fake implements WatchlistTvEvent {}

class WatchlistTvStateFake extends Fake implements WatchlistTvState {}

void main() {
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUpAll(() {
    registerFallbackValue(WatchlistTvEventFake);
    registerFallbackValue(WatchlistTvStateFake);
  });

  setUp(() {
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<WatchlistTvBloc>.value(
      value: mockWatchlistTvBloc,
      child: MaterialApp(
        home: WatchlistTvPage(),
      ),
    );
  }

  group('Poular Tv Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget());

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockWatchlistTvBloc.state)
          .thenReturn(WatchlistTvHasData(<Tv>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget());

      expect(listViewFinder, findsOneWidget);
    });

     testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockWatchlistTvBloc.state).thenReturn(WatchlistTvError('Server Failure'));
    

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(textFinder, findsOneWidget);
  });

  });
}
