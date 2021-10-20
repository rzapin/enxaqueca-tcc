import 'dart:convert';

import 'package:enxaqueca/core/error/exception.dart';
import 'package:enxaqueca/data/models/crise_model.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CriseLocalDataSource {

  Future<CriseModel> getLastCrise();

  Future<void> cacheCrise(CriseModel recordToCache);

  Future<List<CriseModel>> getLastListOfCrises();

  Future<void> cacheListOfCrises(
      List<CriseModel> listOfCrisesToCache);
}

const CACHED_RECORD = 'CACHED_RECORD';

class CriseLocalDataSourceImpl implements CriseLocalDataSource {
  final SharedPreferences sharedPreferences;

  CriseLocalDataSourceImpl({@required this.sharedPreferences});

  @override
  Future<CriseModel> getLastCrise() {
    final jsonString = sharedPreferences.getString(CACHED_RECORD);
    if (jsonString != null) {
      return Future.value(CriseModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheCrise(CriseModel recordToCache) {
    return sharedPreferences.setString(
      CACHED_RECORD,
      json.encode(recordToCache.toJson()),
    );
  }

  @override
  Future<List<CriseModel>> getLastListOfCrises() {
    // TODO: implement getLastListOfCrises
    return null;
  }

  @override
  Future<void> cacheListOfCrises(
      List<CriseModel> listOfCrisesToCache) {
    // TODO: implement cacheListOfCrises
    return null;
  }
}
