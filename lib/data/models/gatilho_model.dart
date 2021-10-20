import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
class GatilhoModel extends Gatilho {
  GatilhoModel(
      {String id,
      @required String nome,
      DateTime diaHora,
      String userId})
      : super(id: id, nome: nome, diaHora: diaHora, userId: userId);

  factory GatilhoModel.fromJson(Map<String, dynamic> json) {
    return GatilhoModel(
        id: json['id'],
        nome: json['nome'],
        diaHora: json['diaHora'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'diaHora': diaHora,
      'userId': userId
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
