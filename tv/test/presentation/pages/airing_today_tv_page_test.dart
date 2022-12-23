import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mocktail/mocktail.dart';
import 'package:tv/presentation/bloc/airing_today/airing_today_bloc.dart';
import 'package:tv/presentation/pages/airing_today_tv_page.dart';

class MockAiringTodayBloc
    extends MockBloc<AiringTodayEvent, AiringTodayState>
    implements AiringTodayBloc {}

class AiringTodayEventFake extends Fake implements AiringTodayEvent {}

class AiringTodayStateFake extends Fake implements AiringTodayState {}

void main() {
  late MockAiringTodayBloc mockAiringTodayBloc;

  setUpAll(() {
    registerFallbackValue(AiringTodayEventFake);
    registerFallbackValue(AiringTodayStateFake);
  });

  setUp(() {
    mockAiringTodayBloc = MockAiringTodayBloc();
  });

  Widget _makeTestableWidget() {
    return BlocProvider<AiringTodayBloc>.value(
      value: mockAiringTodayBloc,
      child: MaterialApp(
        home: AiringTodayTvPage(),
      ),
    );
  }

  group('Airing Today Tv Page', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state)
          .thenReturn(AiringTodayLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(_makeTestableWidget());

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('Page should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => mockAiringTodayBloc.state)
          .thenReturn(AiringTodayHasData(<Tv>[]));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget());

      expect(listViewFinder, findsOneWidget);
    });

     testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockAiringTodayBloc.state).thenReturn(AiringTodayError('Server Failure'));
    

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget());

    expect(textFinder, findsOneWidget);
  });

  });
}
