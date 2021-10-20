part of 'sintoma_bloc.dart';

@immutable
abstract class SintomaState extends Equatable {
  @override
  List<Object> get props => [];
}

class SintomaInitial extends SintomaState {}

class SintomaLoading extends SintomaState {}

class SintomaLoaded extends SintomaState {
  final List<Sintoma> sintomas;

  SintomaLoaded({@required this.sintomas});
}

class SintomaError extends SintomaState {
  final String message;

  SintomaError({@required this.message});

  @override
  List<Object> get props => [message];
}
