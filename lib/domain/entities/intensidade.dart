import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Intensidade extends Equatable {
  final String id;
  final int intensidade;
  final String codigoCor;
  final String userId;

  Intensidade({this.id, @required this.intensidade, this.codigoCor, this.userId});

  @override
  String toString() => '$id, $intensidade, $codigoCor, $userId';

  @override
  List<Object> get props => [id, intensidade, codigoCor, userId];
}
