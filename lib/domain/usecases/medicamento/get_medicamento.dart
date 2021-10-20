import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/domain/repositories/medicamento_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class GetMedicamento extends UseCase<Medicamento, GetMedicamentoParams> {
  final MedicamentoRepository repository;

  GetMedicamento(this.repository);

  @override
  Future<Either<Failure, Medicamento>> call(GetMedicamentoParams params) async {
    return await repository.getMedicamento(params.uid);
  }
}

class GetMedicamentoParams extends Equatable {
  final String uid;

  GetMedicamentoParams({@required this.uid});

  @override
  List<Object> get props => [uid];
}
