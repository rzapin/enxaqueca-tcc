part of 'medicamento_bloc.dart';

@immutable
abstract class MedicamentoEvent extends Equatable {
  const MedicamentoEvent();

  @override
  List<Object> get props => [];
}

class GetAllMedicamentosEvent extends MedicamentoEvent {}

class GetNomeMedicamentosEvent extends MedicamentoEvent {}

class NewMedicamentoEvent extends MedicamentoEvent {
  final Medicamento medicamento;

  NewMedicamentoEvent(this.medicamento);
}

class DeleteMedicamentoEvent extends MedicamentoEvent {
  final String uid;

  DeleteMedicamentoEvent(this.uid);
}

class GetMedicamentoEvent extends MedicamentoEvent {
  final String uid;

  GetMedicamentoEvent(this.uid);
}
