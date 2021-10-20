import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:enxaqueca/domain/repositories/sintoma_repository.dart';

class GetAllSintomas extends UseCase<List<Sintoma>, NoParams> {
  final SintomaRepository repository;

  GetAllSintomas(this.repository);

  @override
  Future<Either<Failure, List<Sintoma>>> call(NoParams params) async {
    return await repository.getAllSintomas();
  }
}
