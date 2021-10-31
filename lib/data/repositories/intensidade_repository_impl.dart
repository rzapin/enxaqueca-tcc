import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/network/network_info.dart';
import 'package:enxaqueca/data/datasources/intensidade_local_data_source.dart';
import 'package:enxaqueca/data/datasources/intensidade_remote_data_sourde.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:enxaqueca/domain/repositories/intensidade_repository.dart';
import 'package:meta/meta.dart';

class IntensidadeRepositoryImpl implements IntensidadeRepository {
  final IntensidadeRemoteDataSource remoteDataSource;
  final IntensidadeLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  IntensidadeRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Intensidade>>> getAllIntensidades() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteListOfIntensidades =
        await remoteDataSource.getAllIntensidades();

        localDataSource.cacheListOfIntensidades(remoteListOfIntensidades);

        return Right(remoteListOfIntensidades);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localListOfIntensidades =
        await localDataSource.getLastListOfIntensidades();
        return Right(localListOfIntensidades);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  // ignore: missing_return
  Future<Either<Failure, void>> updateIntensidade(Intensidade intensidade) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateIntensidade(intensidade);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(CacheFailure());
    }
  }
}
