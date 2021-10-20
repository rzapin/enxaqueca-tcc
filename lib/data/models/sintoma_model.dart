import 'package:enxaqueca/domain/entities/sintoma.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
class SintomaModel extends Sintoma {
  SintomaModel(
      {String id,
        @required String nome,
        @required DateTime horaInicio,
        DateTime horaFim,
        String userId})
      : super(id: id, nome: nome, horaInicio: horaInicio, horaFim: horaFim, userId: userId);

  factory SintomaModel.fromJson(Map<String, dynamic> json) {
    return SintomaModel(
        id: json['id'],
        nome: json['nome'],
        horaInicio: json['horaInicio'],
        horaFim: json['horaFim'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'horaInicio': horaInicio,
      'horaFim': horaFim,
      'userId': userId
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
