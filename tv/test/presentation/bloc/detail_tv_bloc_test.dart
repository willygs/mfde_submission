import 'package:bloc_test/bloc_test.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv/domain/usecases/get_tv_detail.dart';
import 'package:tv/presentation/bloc/detail/detail_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTvDetail])
void main() {
  
  late DetailTvBloc detailTvBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp((){
    mockGetTvDetail = MockGetTvDetail();
    detailTvBloc = DetailTvBloc(mockGetTvDetail);
  });

   test('initial state should be empty', () {
    expect(detailTvBloc.state, DetailTvEmpty());
  });

  final tId = 130392;
  group('Detail Tv', () {
    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(OnDetailTv(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [
        DetailTvLoading(),
        DetailTvHasData(testTvDetail)
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );

    blocTest<DetailTvBloc, DetailTvState>(
      'Should emit [Loading, Error] when get detail Tv is unsuccessful',
      build: () {
        when(mockGetTvDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return detailTvBloc;
      },
      act: (bloc) => bloc.add(OnDetailTv(tId)),
      expect: () => [
        DetailTvLoading(),
        DetailTvError('Server Failure')
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(tId));
      },
    );


  });
}