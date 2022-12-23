import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:tv/domain/usecases/get_top_rated_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvRepository mockTvRepository;

  setUp((){
    mockTvRepository = MockTvRepository();
    usecase = GetTopRatedTv(mockTvRepository);
  });

  final listTv = <Tv>[];

  group('Get Top Rated TV', (){

    group('execute', (){
      test('should get list of tv from the repository when execute function is called', 
        () async {
          //arrange
          when(mockTvRepository.getTopRatedTv())
            .thenAnswer((_) async => Right(listTv));
          //act
          final result = await usecase.execute();
          //assert
          expect(result, Right(listTv));
        }
      );
    });
  });
}