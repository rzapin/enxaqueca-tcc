import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';

abstract class MedicamentoRepository {
  Future<Either<Failure, List<Medicamento>>> getAllMedicamentos();
  Future<Either<Failure, List<Medicamento>>> getNomeMedicamentos();
  Future<Either<Failure, String>> newMedicamento(Medicamento medicamento);
  Future<Either<Failure, void>> deleteMedicamento(String uid);
  Future<Either<Failure, Medicamento>> getMedicamento(String uid);
}
