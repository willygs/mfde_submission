import 'dart:io';

import '../../utils/failure.dart';
import 'package:dartz/dartz.dart';
import '../../data/datasources/tv_local_data_source.dart';
import '../../data/datasources/tv_remote_data_source.dart';
import '../../data/models/tv_table.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/repositories/tv_repository.dart';

import '../../utils/exception.dart';

class TvRepositoryImpl implements TvRepository {
  final TvRemoteDataSource tvRemoteDataSource;
  final TvLocalDataSource tvLocalDataSource;

  TvRepositoryImpl(
      {required this.tvRemoteDataSource, required this.tvLocalDataSource});

  @override
  Future<Either<Failure, List<Tv>>> getAiringTodayTv() async {
    try {
      final result = await tvRemoteDataSource.getAiringTodayTv();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('Certificate Verify Failed'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getPopularTv() async {
    try {
      final result = await tvRemoteDataSource.getPopularTv();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('Certificate Verify Failed'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTopRatedTv() async {
    try {
      final result = await tvRemoteDataSource.getTopRatedTv();
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('Certificate Verify Failed'));
    }
  }

  @override
  Future<Either<Failure, TvDetail>> getTvDetail(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvDetail(id);
      return right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('Certificate Verify Failed'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getTvRecommendations(int id) async {
    try {
      final result = await tvRemoteDataSource.getTvRecommendations(id);
      return right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException {
      return Left(SSLFailure('Certificate Verify Failed'));
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> getWatchlistTv() async {
    final result = await tvLocalDataSource.getWatchlistTv();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlistTv(int id) async {
    final result = await tvLocalDataSource.getTvById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> removeWatchlistTv(TvDetail tv) async {
    try {
      final result =
          await tvLocalDataSource.removeWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlistTv(TvDetail tv) async {
    try {
      final result =
          await tvLocalDataSource.insertWatchlistTv(TvTable.fromEntity(tv));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, List<Tv>>> searchTv(String query) async {
    try {
      final result = await tvRemoteDataSource.searchTv(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure(''));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}
