import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Gatilho extends Equatable {
  final String id;
  final String nome;
  final DateTime diaHora;
  final String userId;

  Gatilho({this.id, @required this.nome, this.diaHora, this.userId});

  @override
  String toString() => '$id, $nome, $diaHora, $userId';

  @override
  List<Object> get props => [id, nome, diaHora, userId];
}
