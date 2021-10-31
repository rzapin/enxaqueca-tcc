import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:enxaqueca/domain/repositories/intensidade_repository.dart';

class GetAllIntensidades extends UseCase<List<Intensidade>, NoParams> {
  final IntensidadeRepository repository;

  GetAllIntensidades(this.repository);

  @override
  Future<Either<Failure, List<Intensidade>>> call(NoParams params) async {
    return await repository.getAllIntensidades();
  }
}
