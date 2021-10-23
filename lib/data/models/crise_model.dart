import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';


@JsonSerializable(anyMap: true, explicitToJson: true)
class CriseModel extends Crise {
  CriseModel({
      String id,
      @required DateTime diaHoraInicio,
      DateTime diaHoraFim,
      @required int intensidade,
      String medicamento,
      String gatilho,
      String sintoma,
      String userId})
      : super(
            id: id,
            diaHoraInicio: diaHoraInicio,
            diaHoraFim: diaHoraFim,
            intensidade: intensidade,
            medicamento: medicamento,
            gatilho: gatilho,
            sintoma: sintoma,
            userId: userId);

  factory CriseModel.fromJson(Map<dynamic, dynamic> json) {

    return CriseModel(
        id: json['id'],
        diaHoraInicio: json['diaHoraInicio'],
        diaHoraFim: json['diaHoraFim'],
        intensidade: json['intensidade'],
        medicamento:json['medicamento'],
        gatilho: json['gatilho'],
        sintoma: json['sintoma'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'diaHoraInicio': diaHoraInicio,
      'diaHoraFim': diaHoraFim,
      'intensidade': intensidade,
      'medicamento': medicamento,
      'gatilho': gatilho,
      'sintoma': sintoma,
      'userId': userId
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
