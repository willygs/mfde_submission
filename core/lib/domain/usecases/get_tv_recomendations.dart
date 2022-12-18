

import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../../domain/entities/tv.dart';
import '../../domain/repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;
  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id){
    return repository.getTvRecommendations(id);
  }
}