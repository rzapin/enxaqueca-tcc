import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:enxaqueca/domain/repositories/medicamento_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class NewMedicamento extends UseCase<String, NewMedicamentoParams> {
  final MedicamentoRepository repository;

  NewMedicamento(this.repository);

  @override
  Future<Either<Failure, String>> call(NewMedicamentoParams params) async {
    return await repository.newMedicamento(params.medicamento);
  }
}

class NewMedicamentoParams extends Equatable {
  final Medicamento medicamento;

  NewMedicamentoParams({@required this.medicamento});

  @override
  List<Object> get props => [medicamento];
}
