import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/domain/entities/gatilho.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';

abstract class IntensidadeRepository {
  Future<Either<Failure, List<Intensidade>>> getAllIntensidades();
  Future<Either<Failure, void>> updateIntensidade(Intensidade intensidade);
}