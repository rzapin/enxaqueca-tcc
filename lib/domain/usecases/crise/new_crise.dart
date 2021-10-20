import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/repositories/crise_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewCrise extends UseCase<String, NewCriseParams> {
  final CriseRepository repository;

  NewCrise(this.repository);

  @override
  Future<Either<Failure, String>> call(NewCriseParams params) async {
    return await repository.newCrise(params.crise);
  }
}

class NewCriseParams extends Equatable {
  final Crise crise;

  NewCriseParams({@required this.crise});

  @override
  List<Object> get props => [crise];
}
