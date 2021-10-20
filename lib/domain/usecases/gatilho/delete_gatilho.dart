import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/repositories/gatilho_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DeleteGatilho extends UseCase<String, DeleteGatilhoParams> {
  final GatilhoRepository repository;

  DeleteGatilho(this.repository);

  @override
  Future<Either<Failure, String>> call(DeleteGatilhoParams params) async {
    return await repository.deleteGatilho(params.uid);
  }
}

class DeleteGatilhoParams extends Equatable {
  final String uid;

  DeleteGatilhoParams({@required this.uid});

  @override
  List<Object> get props => [uid];
}
