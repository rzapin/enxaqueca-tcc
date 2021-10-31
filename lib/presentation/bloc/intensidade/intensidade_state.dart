part of 'intensidade_bloc.dart';

@immutable
abstract class IntensidadeState extends Equatable {
  @override
  List<Object> get props => [];
}

class IntensidadeInitial extends IntensidadeState {}

class IntensidadeLoading extends IntensidadeState {}

class IntensidadeLoaded extends IntensidadeState {
  final List<Intensidade> intensidades;

  IntensidadeLoaded({@required this.intensidades});
}

class IntensidadeError extends IntensidadeState {
  final String message;

  IntensidadeError({@required this.message});

  @override
  List<Object> get props => [message];
}
