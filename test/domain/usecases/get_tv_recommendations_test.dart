import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_recomendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvRecommendations usecases;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    usecases = GetTvRecommendations(mockTvRepository);
  });

  final id = 210855;
  final tTv = <Tv>[];

  test('TV Recommendations : hould get list of tv recommendations from the repository', 
    () async {
      //arrange
      when(mockTvRepository.getTvRecommendations(id))
        .thenAnswer((_) async => Right(tTv));
      //act
      final result = await usecases.execute(id);
      //assert
      expect(result, Right(tTv));
    }
  );
}