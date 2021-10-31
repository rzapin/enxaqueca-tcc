import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/data/models/intensidade_model.dart';
import 'package:enxaqueca/domain/entities/intensidade.dart';
import 'package:meta/meta.dart';

abstract class IntensidadeRemoteDataSource {
  Future<List<IntensidadeModel>> getAllIntensidades();
  Future<void> updateIntensidade(Intensidade intensidade);
}

class IntensidadeRemoteDataSourceImpl implements IntensidadeRemoteDataSource {
  final FirebaseFirestore firestore;

  IntensidadeRemoteDataSourceImpl({@required this.firestore});

  @override
  Future<List<IntensidadeModel>> getAllIntensidades() async {
    var result = await firestore.collection('intensidades').get();

    List<IntensidadeModel> listIntensidadeModel = result.docs
        .map((doc) => IntensidadeModel(
      id: doc.id,
      intensidade: doc.get('intensidade'),
      codigoCor: doc.get('codigoCor'),
      //  userId: doc.get('userId')
    ))
        .toList();

    return listIntensidadeModel;
  }

  @override
  Future<void> updateIntensidade(Intensidade intensidade) async {
    await firestore
        .collection('intensidades')
        .doc(intensidade.id)
        .update(
        {
          'intensidade': intensidade.intensidade,
          'codigoCor': intensidade.codigoCor,
          //'userId': crise.userId,
        }
    );
  }
}
