import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvDetail usecases;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    usecases = GetTvDetail(mockTvRepository);
  });

  final id = 210855;

  test('TV Detail : should get tv detail from the repository', () async {
    //arrange
    when(mockTvRepository.getTvDetail(id))
      .thenAnswer((_) async => Right(testTvDetail));
    //act
    final result = await usecases.execute(id);
    //assert
    expect(result, Right(testTvDetail));
  });
}