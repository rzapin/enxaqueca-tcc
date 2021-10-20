import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';

abstract class GatilhoRepository {
  Future<Either<Failure, List<Gatilho>>> getAllGatilhos();
  Future<Either<Failure, String>> newGatilho(Gatilho gatilho);
  Future<Either<Failure, void>> deleteGatilho(String uid);
}