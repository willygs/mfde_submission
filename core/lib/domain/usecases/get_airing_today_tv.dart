import 'package:dartz/dartz.dart';
import '../../utils/failure.dart';
import '../../domain/entities/tv.dart';
import '../../domain/repositories/tv_repository.dart';

class GetAiringTodayTv {

  final TvRepository repository;

  GetAiringTodayTv(
    this.repository
  );

  Future<Either<Failure,List<Tv>>> execute(){
    return repository.getAiringTodayTv();
  }
  
}