part of 'crise_med_bloc.dart';

@immutable
abstract class CrisesWithMedState extends Equatable {
  @override
  List<Object> get props => [];
}

class CrisesWithMedInitial extends CrisesWithMedState {}

class CrisesWithMedLoading extends CrisesWithMedState {}

class CrisesWithMedWithMedLoading extends CrisesWithMedState {}

//Estado para quando a lista de todas as crises carrega
class CrisesWithMedLoaded extends CrisesWithMedState {
  final List<Crise> crisesWithMed;

  CrisesWithMedLoaded({@required this.crisesWithMed,});
}

//Estado para quando carrega a lista de crises apenas com registros medicamento != null
class CrisesWithMedWithMedLoaded extends CrisesWithMedState {
  final List<Crise> crises;

  CrisesWithMedWithMedLoaded({@required this.crises,});
}

class CrisesWithMedError extends CrisesWithMedState {
  final String message;

  CrisesWithMedError({@required this.message});

  @override
  List<Object> get props => [message];
}
