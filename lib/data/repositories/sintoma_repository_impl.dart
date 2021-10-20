import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/network/network_info.dart';
import 'package:enxaqueca/data/datasources/sintoma_local_data_source.dart';
import 'package:enxaqueca/data/datasources/sintoma_remote_data_source.dart';
import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:enxaqueca/domain/repositories/sintoma_repository.dart';
import 'package:meta/meta.dart';

class SintomaRepositoryImpl implements SintomaRepository {
  final SintomaRemoteDataSource remoteDataSource;
  final SintomaLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  SintomaRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Sintoma>>> getAllSintomas() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListOfSintomas =
        await remoteDataSource.getAllSintomas();

        localDataSource.cacheListOfSintomas(remoteListOfSintomas);

        return Right(remoteListOfSintomas);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListOfSintomas =
        await localDataSource.getLastListOfSintomas();
        return Right(localListOfSintomas);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Sintoma>> getSintoma(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteSintoma = await remoteDataSource.getSintoma(uid);
        localDataSource.cacheSintoma(remoteSintoma);
        return Right(remoteSintoma);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localSintoma = await localDataSource.getLastSintoma();
        return Right(localSintoma);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> newSintoma(
      Sintoma sintoma) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await remoteDataSource.newSintoma(sintoma);
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
  Future<Either<Failure, void>> deleteSintoma(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteSintoma(uid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
