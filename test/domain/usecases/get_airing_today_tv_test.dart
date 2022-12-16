import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetAiringTodayTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetAiringTodayTv(mockTvRepository);
  });

  final listTv = <Tv>[];

  test('Airing Today : should get list of tv from the repository', () async {
    //arrange
    when(mockTvRepository.getAiringTodayTv())
        .thenAnswer((_) async => Right(listTv));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(listTv));
  });
}
