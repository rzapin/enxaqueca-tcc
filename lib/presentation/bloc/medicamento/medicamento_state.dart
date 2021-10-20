part of 'medicamento_bloc.dart';

@immutable
abstract class MedicamentoState extends Equatable {
  @override
  List<Object> get props => [];
}

class MedicamentoInitial extends MedicamentoState {}

class MedicamentoLoading extends MedicamentoState {}

class MedicamentoLoaded extends MedicamentoState {
  final List<Medicamento> medicamentos;

  MedicamentoLoaded({@required this.medicamentos});
}

class MedicamentoError extends MedicamentoState {
  final String message;

  MedicamentoError({@required this.message});

  @override
  List<Object> get props => [message];
}
