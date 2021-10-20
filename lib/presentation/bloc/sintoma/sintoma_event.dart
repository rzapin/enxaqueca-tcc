part of 'sintoma_bloc.dart';

@immutable
abstract class SintomaEvent extends Equatable {
  const SintomaEvent();

  @override
  List<Object> get props => [];
}

class GetAllSintomasEvent extends SintomaEvent {}

class NewSintomaEvent extends SintomaEvent {
  final Sintoma sintoma;

  NewSintomaEvent(this.sintoma);
}

class DeleteSintomaEvent extends SintomaEvent {
  final String uid;

  DeleteSintomaEvent(this.uid);
}
