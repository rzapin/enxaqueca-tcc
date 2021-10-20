part of 'crise_bloc.dart';

@immutable
abstract class CriseState extends Equatable {
  @override
  List<Object> get props => [];
}

class CriseInitial extends CriseState {}

class CriseLoading extends CriseState {}

class CriseLoaded extends CriseState {
  final List<Crise> crises;

  CriseLoaded({@required this.crises});
}

class CriseError extends CriseState {
  final String message;

  CriseError({@required this.message});

  @override
  List<Object> get props => [message];
}
