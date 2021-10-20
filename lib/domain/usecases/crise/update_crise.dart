import 'package:dartz/dartz.dart';
import 'package:enxaqueca/core/error/failures.dart';
import 'package:enxaqueca/core/usecases/usecase.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:enxaqueca/domain/repositories/crise_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class UpdateCrise extends UseCase<String, UpdateCriseParams> {
  final CriseRepository repository;

  UpdateCrise(this.repository);

  @override
  Future<Either<Failure, String>> call(UpdateCriseParams params) async {
    return await repository.updateCrise(params.crise);
  }
}

class UpdateCriseParams extends Equatable {
  final Crise crise;

  UpdateCriseParams({@required this.crise});

  @override
  List<Object> get props => [crise];
}
