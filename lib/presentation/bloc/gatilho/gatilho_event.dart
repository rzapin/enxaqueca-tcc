part of 'gatilho_bloc.dart';

@immutable
abstract class GatilhoEvent extends Equatable {
  const GatilhoEvent();

  @override
  List<Object> get props => [];
}

class GetAllGatilhosEvent extends GatilhoEvent {}

class NewGatilhoEvent extends GatilhoEvent {
  final Gatilho gatilho;

  NewGatilhoEvent(this.gatilho);
}

class DeleteGatilhoEvent extends GatilhoEvent {
  final String uid;

  DeleteGatilhoEvent(this.uid);
}
