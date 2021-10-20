import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/repositories/sintoma_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DeleteSintoma extends UseCase<String, DeleteSintomaParams> {
  final SintomaRepository repository;

  DeleteSintoma(this.repository);

  @override
  Future<Either<Failure, String>> call(DeleteSintomaParams params) async {
    return await repository.deleteSintoma(params.uid);
  }
}

class DeleteSintomaParams extends Equatable {
  final String uid;

  DeleteSintomaParams({@required this.uid});

  @override
  List<Object> get props => [uid];
}
