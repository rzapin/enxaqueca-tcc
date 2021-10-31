part of 'crise_bloc.dart';

@immutable
abstract class CriseState extends Equatable {
  @override
  List<Object> get props => [];
}

class CriseInitial extends CriseState {}

class CriseLoading extends CriseState {}

class CriseWithMedLoading extends CriseState {}

//Estado para quando a lista de todas as crises carrega
class CriseLoaded extends CriseState {
  final List<Crise> crises;

  CriseLoaded({@required this.crises,});
}

//Estado para quando carrega a lista de crises apenas com registros medicamento != null
class CriseWithMedLoaded extends CriseState {
  final List<Crise> crises;

  CriseWithMedLoaded({@required this.crises,});
}

class CriseError extends CriseState {
  final String message;

  CriseError({@required this.message});

  @override
  List<Object> get props => [message];
}
