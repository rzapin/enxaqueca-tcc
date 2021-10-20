import 'dart:convert';

import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/data/models/medicamento_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MedicamentoLocalDataSource {
  
  Future<MedicamentoModel> getLastMedicamento();

  Future<void> cacheMedicamento(MedicamentoModel recordToCache);

  Future<List<MedicamentoModel>> getLastListOfMedicamentos();

  Future<void> cacheListOfMedicamentos(
      List<MedicamentoModel> listOfMedicamentosToCache);
}

const CACHED_RECORD = 'CACHED_RECORD';

class MedicamentoLocalDataSourceImpl implements MedicamentoLocalDataSource {
  final SharedPreferences sharedPreferences;

  MedicamentoLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<MedicamentoModel> getLastMedicamento() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(MedicamentoModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheMedicamento(MedicamentoModel recordToCache) {
    return sharedPreferences.setString(
      CACHED_RECORD,
      json.encode(recordToCache.toJson()),
    );
  }

  @override
  Future<List<MedicamentoModel>> getLastListOfMedicamentos() {
    // TODO: implement getLastListOfMedicamentos
    return null;
  }

  @override
  Future<void> cacheListOfMedicamentos(
      List<MedicamentoModel> listOfMedicamentosToCache) {
    // TODO: implement cacheListOfMedicamentos
    return null;
  }
}
