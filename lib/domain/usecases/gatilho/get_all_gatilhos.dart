import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/domain/repositories/gatilho_repository.dart';

class GetAllGatilhos extends UseCase<List<Gatilho>, NoParams> {
  final GatilhoRepository repository;

  GetAllGatilhos(this.repository);

  @override
  Future<Either<Failure, List<Gatilho>>> call(NoParams params) async {
    return await repository.getAllGatilhos();
  }
}
