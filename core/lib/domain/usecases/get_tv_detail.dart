

import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

class GetTvDetail {

  final TvRepository repository;
  GetTvDetail(this.repository);

  Future<Either<Failure,TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}