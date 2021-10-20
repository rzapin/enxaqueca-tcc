import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/repositories/medicamento_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class DeleteMedicamento extends UseCase<String, DeleteMedicamentoParams> {
  final MedicamentoRepository repository;

  DeleteMedicamento(this.repository);

  @override
  Future<Either<Failure, String>> call(DeleteMedicamentoParams params) async {
    return await repository.deleteMedicamento(params.uid);
  }
}

class DeleteMedicamentoParams extends Equatable {
  final String uid;

  DeleteMedicamentoParams({@required this.uid});

  @override
  List<Object> get props => [uid];
}
