import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/network/network_info.dart';
import 'package:enxaqueca/data/datasources/gatilho_local_data_source.dart';
import 'package:enxaqueca/data/datasources/gatilho_remote_data_source.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/domain/repositories/gatilho_repository.dart';
import 'package:meta/meta.dart';

class GatilhoRepositoryImpl implements GatilhoRepository {
  final GatilhoRemoteDataSource remoteDataSource;
  final GatilhoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  GatilhoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Gatilho>>> getAllGatilhos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListOfGatilhos =
        await remoteDataSource.getAllGatilhos();

        localDataSource.cacheListOfGatilhos(remoteListOfGatilhos);

        return Right(remoteListOfGatilhos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListOfGatilhos =
        await localDataSource.getLastListOfGatilhos();
        return Right(localListOfGatilhos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Gatilho>> getGatilho(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteGatilho = await remoteDataSource.getGatilho(uid);
        localDataSource.cacheGatilho(remoteGatilho);
        return Right(remoteGatilho);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localGatilho = await localDataSource.getLastGatilho();
        return Right(localGatilho);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> newGatilho(
      Gatilho gatilho) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await remoteDataSource.newGatilho(gatilho);
        return Right(uid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        //todo: o que fazer quando não tem internet e quer adicionar um registro no firestores
        } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  // ignore: missing_return
  Future<Either<Failure, void>> deleteGatilho(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteGatilho(uid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
