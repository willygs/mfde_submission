import 'package:ditonton/domain/usecases/get_watchlist_status_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListStatusTv usecase;
  late MockTvRepository mockTvRepository;
  
  setUp((){
    mockTvRepository = MockTvRepository();
    usecase = GetWatchListStatusTv(mockTvRepository);
  });

  final id = 210855;
  test('should get watchlist status from repository', () async {
    //arrangge
    when(mockTvRepository.isAddedToWatchlistTv(id))
      .thenAnswer((_) async => true);

    //act 
    final result = await usecase.execute(id);

    //assert
    expect(result, true);
  });

}