import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_popular_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTv usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTv(mockTvRepository);
  });

  final listTv = <Tv>[];

  test('Popular TV : should get list of tv from the repository', () async {
    //arrange
    when(mockTvRepository.getPopularTv())
      .thenAnswer((_) async => Right(listTv));
    //act
    final result = await usecase.execute();
    //assert
    expect(result,Right(listTv));
  });
}
