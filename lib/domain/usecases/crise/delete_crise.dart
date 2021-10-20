import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/repositories/crise_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DeleteCrise extends UseCase<String, DeleteCriseParams> {
  final CriseRepository repository;

  DeleteCrise(this.repository);

  @override
  Future<Either<Failure, String>> call(DeleteCriseParams params) async {
    return await repository.deleteCrise(params.uid);
  }
}

class DeleteCriseParams extends Equatable {
  final String uid;

  DeleteCriseParams({@required this.uid});

  @override
  List<Object> get props => [uid];
}
