import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/network/network_info.dart';
import 'package:enxaqueca/data/datasources/crise_local_data_source.dart';
import 'package:enxaqueca/data/datasources/crise_remote_data_source.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/repositories/crise_repository.dart';
import 'package:meta/meta.dart';

class CriseRepositoryImpl implements CriseRepository {
  final CriseRemoteDataSource remoteDataSource;
  final CriseLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  CriseRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Crise>>> getAllCrises() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListOfCrises =
        await remoteDataSource.getAllCrises();

        localDataSource.cacheListOfCrises(remoteListOfCrises);

        return Right(remoteListOfCrises);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListOfCrises =
        await localDataSource.getLastListOfCrises();
        return Right(localListOfCrises);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Crise>> getCrise(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteCrise = await remoteDataSource.getCrise(uid);
        localDataSource.cacheCrise(remoteCrise);
        return Right(remoteCrise);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localCrise = await localDataSource.getLastCrise();
        return Right(localCrise);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> newCrise(
      Crise crise) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await remoteDataSource.newCrise(crise);
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
  Future<Either<Failure, void>> deleteCrise(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteCrise(uid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }

  @override
  // ignore: missing_return
  Future<Either<Failure, void>> updateCrise(Crise crise) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateCrise(crise);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
