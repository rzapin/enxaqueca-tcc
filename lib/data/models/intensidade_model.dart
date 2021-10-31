import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
class IntensidadeModel extends Intensidade {
  IntensidadeModel(
      {String id,
        @required int intensidade,
        @required String codigoCor,
        String userId})
      : super(id: id, intensidade: intensidade, codigoCor: codigoCor, userId: userId);

  factory IntensidadeModel.fromJson(Map<String, dynamic> json) {
    return IntensidadeModel(
        id: json['id'],
        intensidade: json['intensidade'],
        codigoCor: json['codigoCor'],
        userId: json['userId']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'intensidade': intensidade,
      'codigoCor': codigoCor,
      'userId': userId
    };
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
