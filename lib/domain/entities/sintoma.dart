import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Sintoma extends Equatable {
  final String id;
  final String nome;
  final DateTime horaInicio;
  final DateTime horaFim;
  final String userId;

  Sintoma({this.id, @required this.nome, @required this.horaInicio, this.horaFim, this.userId});

  @override
  String toString() => '$id, $nome, $horaInicio, $horaFim, $userId';

  @override
  List<Object> get props => [id, nome, horaInicio, horaFim, userId];
}
