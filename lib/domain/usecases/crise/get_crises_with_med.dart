import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/repositories/crise_repository.dart';

class GetCrisesWithMed extends UseCase<List<Crise>, NoParams> {
  final CriseRepository repository;

  GetCrisesWithMed(this.repository);

  @override
  Future<Either<Failure, List<Crise>>> call(NoParams params) async {
    return await repository.getCrisesWithMed();
  }
}
