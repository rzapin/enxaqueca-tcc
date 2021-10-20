part of 'gatilho_bloc.dart';

@immutable
abstract class GatilhoState extends Equatable {
  @override
  List<Object> get props => [];
}

class GatilhoInitial extends GatilhoState {}

class GatilhoLoading extends GatilhoState {}

class GatilhoLoaded extends GatilhoState {
  final List<Gatilho> gatilhos;

  GatilhoLoaded({@required this.gatilhos});
}

class GatilhoError extends GatilhoState {
  final String message;

  GatilhoError({@required this.message});

  @override
  List<Object> get props => [message];
}
