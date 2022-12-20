import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetAiringTodayTv {

  final TvRepository repository;

  GetAiringTodayTv(
    this.repository
  );

  Future<Either<Failure,List<Tv>>> execute(){
    return repository.getAiringTodayTv();
  }
  
}