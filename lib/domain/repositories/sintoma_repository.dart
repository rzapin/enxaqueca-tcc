import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/domain/entities/sintoma.dart';

abstract class SintomaRepository {
  Future<Either<Failure, List<Sintoma>>> getAllSintomas();
  Future<Either<Failure, String>> newSintoma(Sintoma gatilho);
  Future<Either<Failure, void>> deleteSintoma(String uid);
}