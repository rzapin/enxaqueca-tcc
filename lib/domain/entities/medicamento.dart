import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Medicamento extends Equatable {
  final String id;
  final String nome;
  final int dosagem;
  final String codigoCor;
  final String userId;

  Medicamento(
      {this.id,
      @required this.nome,
      @required this.dosagem,
      @required this.codigoCor,
      this.userId,
      });

  @override
  String toString() => '$id, $nome, $dosagem, $codigoCor, $userId';

  @override
  List<Object> get props => [id, nome, dosagem, codigoCor, userId];
}
