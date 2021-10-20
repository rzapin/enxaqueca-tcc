import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/domain/repositories/gatilho_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewGatilho extends UseCase<String, NewGatilhoParams> {
  final GatilhoRepository repository;

  NewGatilho(this.repository);

  @override
  Future<Either<Failure, String>> call(NewGatilhoParams params) async {
    return await repository.newGatilho(params.gatilho);
  }
}

class NewGatilhoParams extends Equatable {
  final Gatilho gatilho;

  NewGatilhoParams({@required this.gatilho});

  @override
  List<Object> get props => [gatilho];
}
