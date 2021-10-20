import 'package:enxaqueca/domain/entities/medicamento.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable(anyMap: true, explicitToJson: true)
class MedicamentoModel extends Medicamento {
  MedicamentoModel(
      {String id,
      @required String nome,
      @required int dosagem,
      @required String codigoCor,
      String userId
      })
      : super(id: id, nome: nome, dosagem: dosagem, codigoCor: codigoCor, userId: userId);

  factory MedicamentoModel.fromJson(Map<dynamic, dynamic> json) {
    return MedicamentoModel(
        id: json['id'],
        nome: json['nome'],
        dosagem: json['dosagem'],
        codigoCor: json['codigoCor'],
        userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'dosagem': dosagem, 'codigoCor': codigoCor, 'userId': userId};
  }

   @override
   // TODO: implement props
   List<Object> get props => [id, nome, dosagem, codigoCor, userId];
}
