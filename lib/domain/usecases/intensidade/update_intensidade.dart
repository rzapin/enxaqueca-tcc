import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:enxaqueca/domain/repositories/intensidade_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UpdateIntensidade extends UseCase<String, UpdateIntensidadeParams> {
  final IntensidadeRepository repository;

  UpdateIntensidade(this.repository);

  @override
  Future<Either<Failure, String>> call(UpdateIntensidadeParams params) async {
    return await repository.updateIntensidade(params.intensidade);
  }
}

class UpdateIntensidadeParams extends Equatable {
  final Intensidade intensidade;

  UpdateIntensidadeParams({@required this.intensidade});

  @override
  List<Object> get props => [intensidade];
}
