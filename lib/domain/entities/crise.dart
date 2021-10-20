import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Crise extends Equatable {
  final String id;
  final DateTime diaHoraInicio;
  final DateTime diaHoraFim;
  final int intensidade;
  final String medicamento;
  final String gatilho;
  final String sintoma;
  final String userId;

  Crise(
      {this.id,
      @required this.diaHoraInicio,
      this.diaHoraFim,
      @required this.intensidade,
      this.medicamento,
      this.gatilho,
      this.sintoma,
      this.userId});

  @override
  String toString() =>
      '$id, $diaHoraInicio, $diaHoraFim, $intensidade, $medicamento, $gatilho, $sintoma, $userId';

  @override
  List<Object> get props => [
        id,
        diaHoraInicio,
        diaHoraFim,
        intensidade,
        medicamento,
        gatilho,
        sintoma,
        userId
      ];
}
