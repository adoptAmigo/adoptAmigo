import 'package:adopta_amigo/app/model/collaborator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Future<Map<dynamic,Collaborator>> getCollaboratorList() async {
  final db = FirebaseFirestore.instance;

  Map<dynamic,Collaborator> returnData = {};

  final querySnapshot = await db.collection("protectoras").get();

  for (var docSnapshot in querySnapshot.docs) {
    final data = docSnapshot.data();

    // Access specific fields in the document
    // var nombre = data['nombre'];
    // var descripcion = data['descripcion'];
    // var especie = data['especie'];
    // var urlImage = data['urlImage'];
    // var idProtectora = data['idProtectora'];
   // animales.pu(Pet.fromMap(data));
    returnData[docSnapshot.id] = Collaborator.fromMap(data);
  }

  return returnData;
}

