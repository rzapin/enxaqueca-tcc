import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enxaqueca/data/models/crise_model.dart';
import 'package:enxaqueca/domain/entities/crise.dart';
import 'package:meta/meta.dart';

abstract class CriseRemoteDataSource {
  Future<List<CriseModel>> getAllCrises();

  Future<CriseModel> getCrise(String uid);

  Future<String> newCrise(Crise crise);

  Future<void> deleteCrise(String uid);

  Future<void> updateCrise(Crise crise);
}

class CriseRemoteDataSourceImpl implements CriseRemoteDataSource {
  final FirebaseFirestore firestore;
  final CollectionReference medicamentos = FirebaseFirestore.instance.collection('medicamentos');
  final CollectionReference gatilhos = FirebaseFirestore.instance.collection('gatilhos');
  final CollectionReference sintomas = FirebaseFirestore.instance.collection('sintomas');

  CriseRemoteDataSourceImpl({@required this.firestore});

 //  String _getMedId(DocumentReference docRef) {
 //   String _medId = FirebaseFirestore.instance.collection("medicamentos").doc('IUuSRbgZPlb3QXpeCRQr').id;
 //   return _medId;
 //  }

  @override
  Future<List<CriseModel>> getAllCrises() async {
    var result = await firestore.collection('crises').get();

    List<CriseModel> listCriseModel = result.docs
        .map((doc) =>
        CriseModel(
          id: doc.id,
          diaHoraInicio: doc.get('diaHoraInicio').toDate(),
          diaHoraFim: doc.get('diaHoraFim').toDate(),
          intensidade: doc.get('intensidade'),
          medicamento: doc.get('medicamento').toString(),
          gatilho: doc.get('gatilho').toString(),
          sintoma: doc.get('sintoma').toString(),
          //  userId: doc.get('userId')
        ),
    )
        .toList();

    return listCriseModel;
  }

  @override
  Future<CriseModel> getCrise(String uid) async {
    Map<String, dynamic> data =
    (await firestore.collection('crises').doc(uid).get()).data();

    return CriseModel.fromJson(data);
  }

  @override
  Future<String> newCrise(Crise crise) async {
    //Trasforma os IDs nao nulos de String para DocumentReference para registro no Firestore
   // DocumentReference medicamentoRef = crise.medicamento == null ? null : medicamentos.doc(crise.medicamento);
    DocumentReference gatilhoRef = crise.gatilho == null ? null : gatilhos.doc(crise.gatilho);
    DocumentReference sintomaRef = crise.sintoma == null ? null : sintomas.doc(crise.sintoma);

    final docRef = firestore.collection("crises").add({
      'diaHoraInicio': crise.diaHoraInicio,
      'diaHoraFim': crise.diaHoraFim,
      'intensidade': crise.intensidade,
      'medicamento': crise.medicamento,
      'gatilho': gatilhoRef,
      'sintoma': sintomaRef,
      //'userId': crise.userId
    });
    print(docRef);
    return docRef.toString();
  }

  @override
  Future<void> deleteCrise(String uid) async {
    await firestore.collection('crises').doc(uid).delete();
  }

  @override
  Future<void> updateCrise(Crise crise) async {
    await firestore
        .collection('crises')
        .doc(crise.id)
        .update(
        {
          'diaHoraInicio': crise.diaHoraInicio,
          'diaHoraFim': crise.diaHoraFim,
          'intensidade': crise.intensidade,
          'medicamento': crise.medicamento,
          'gatilho': crise.gatilho,
          'sintoma': crise.sintoma,
          //'userId': crise.userId),
        }
    );
  }
}


