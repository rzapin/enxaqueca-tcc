part of 'crise_bloc.dart';

@immutable
abstract class CriseEvent extends Equatable {
  const CriseEvent();

  @override
  List<Object> get props => [];
}

class GetAllCrisesEvent extends CriseEvent {}

class NewCriseEvent extends CriseEvent {
  final Crise crise;

  NewCriseEvent(this.crise);
}

class DeleteCriseEvent extends CriseEvent {
  final String uid;

  DeleteCriseEvent(this.uid);
}

class UpdateCriseEvent extends CriseEvent {
  final Crise crise;

  UpdateCriseEvent(this.crise);
}
