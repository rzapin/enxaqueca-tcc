import 'dart:convert';

import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/data/models/intensidade_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IntensidadeLocalDataSource {

  Future<IntensidadeModel> getLastIntensidade();

  Future<void> cacheIntensidade(IntensidadeModel recordToCache);

  Future<List<IntensidadeModel>> getLastListOfIntensidades();

  Future<void> cacheListOfIntensidades(
      List<IntensidadeModel> listOfIntensidadesToCache);
}

const CACHED_RECORD = 'CACHED_RECORD';

class IntensidadeLocalDataSourceImpl implements IntensidadeLocalDataSource {
  final SharedPreferences sharedPreferences;

  IntensidadeLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<IntensidadeModel> getLastIntensidade() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(IntensidadeModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheIntensidade(IntensidadeModel recordToCache) {
    return sharedPreferences.setString(
      CACHED_RECORD,
      json.encode(recordToCache.toJson()),
    );
  }

  @override
  Future<List<IntensidadeModel>> getLastListOfIntensidades() {
    // TODO: implement getLastListOfIntensidades
    return null;
  }

  @override
  Future<void> cacheListOfIntensidades(
      List<IntensidadeModel> listOfIntensidadesToCache) {
    // TODO: implement cacheListOfIntensidades
    return null;
  }
}
