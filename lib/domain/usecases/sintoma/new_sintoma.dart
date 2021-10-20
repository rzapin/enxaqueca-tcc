import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:enxaqueca/domain/repositories/sintoma_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewSintoma extends UseCase<String, NewSintomaParams> {
  final SintomaRepository repository;

  NewSintoma(this.repository);

  @override
  Future<Either<Failure, String>> call(NewSintomaParams params) async {
    return await repository.newSintoma(params.sintoma);
  }
}

class NewSintomaParams extends Equatable {
  final Sintoma sintoma;

  NewSintomaParams({@required this.sintoma});

  @override
  List<Object> get props => [sintoma];
}
