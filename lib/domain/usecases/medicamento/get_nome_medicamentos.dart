import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/domain/repositories/medicamento_repository.dart';

class GetNomeMedicamentos extends UseCase<List<Medicamento>, NoParams> {
  final MedicamentoRepository repository;

  GetNomeMedicamentos(this.repository);

  @override
  Future<Either<Failure, List<Medicamento>>> call(NoParams params) async {
    return await repository.getNomeMedicamentos();
  }
}
