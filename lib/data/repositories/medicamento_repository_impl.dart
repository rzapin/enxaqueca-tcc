import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/network/network_info.dart';
import 'package:enxaqueca/data/datasources/medicamento_local_data_source.dart';
import 'package:enxaqueca/data/datasources/medicamento_remote_data_source.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/domain/repositories/medicamento_repository.dart';
import 'package:meta/meta.dart';

class MedicamentoRepositoryImpl implements MedicamentoRepository {
  final MedicamentoRemoteDataSource remoteDataSource;
  final MedicamentoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  MedicamentoRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Medicamento>>> getAllMedicamentos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListOfMedicamentos =
            await remoteDataSource.getAllMedicamentos();

        localDataSource.cacheListOfMedicamentos(remoteListOfMedicamentos);

        return Right(remoteListOfMedicamentos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListOfMedicamentos =
            await localDataSource.getLastListOfMedicamentos();
        return Right(localListOfMedicamentos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Medicamento>>> getNomeMedicamentos() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListOfMedicamentos =
        await remoteDataSource.getAllMedicamentos();

        localDataSource.cacheListOfMedicamentos(remoteListOfMedicamentos);

        return Right(remoteListOfMedicamentos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListOfMedicamentos =
        await localDataSource.getLastListOfMedicamentos();
        return Right(localListOfMedicamentos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Medicamento>> getMedicamento(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMedicamento = await remoteDataSource.getMedicamento(uid);
        localDataSource.cacheMedicamento(remoteMedicamento);
        return Right(remoteMedicamento);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localMedicamento = await localDataSource.getLastMedicamento();
        return Right(localMedicamento);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, String>> newMedicamento(
      Medicamento medicamento) async {
    if (await networkInfo.isConnected) {
      try {
        final uid = await remoteDataSource.newMedicamento(medicamento);
        return Right(uid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        //todo: o que fazer quando não tem internet e quer adicionar um registro no firestores
        // final localMedicamento = await localDataSource.newMedicamento(record);
        // return Right(localMedicamento);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  // ignore: missing_return
  Future<Either<Failure, void>> deleteMedicamento(String uid) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteMedicamento(uid);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
