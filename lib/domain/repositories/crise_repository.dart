import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/domain/entities/crise.dart';

abstract class CriseRepository {
  Future<Either<Failure, List<Crise>>> getAllCrises();
  Future<Either<Failure, List<Crise>>> getCrisesWithMed();
  Future<Either<Failure, String>> newCrise(Crise crise);
  Future<Either<Failure, void>> deleteCrise(String uid);
  Future<Either<Failure, void>> updateCrise(Crise crise);
}