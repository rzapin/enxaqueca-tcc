part of 'intensidade_bloc.dart';

@immutable
abstract class IntensidadeEvent extends Equatable {
  const IntensidadeEvent();

  @override
  List<Object> get props => [];
}

class GetAllIntensidadesEvent extends IntensidadeEvent {}

class UpdateIntensidadeEvent extends IntensidadeEvent {
  final Intensidade intensidade;

  UpdateIntensidadeEvent(this.intensidade);
}
