import 'package:adoptAmigo/app/model/pet.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<dynamic, Pet>> getPetList() async {
  final db = FirebaseFirestore.instance;

  Map<dynamic, Pet> animales = {};

  final querySnapshot = await db.collection("animales").get();

  for (var docSnapshot in querySnapshot.docs) {
    final data = docSnapshot.data();

    // Access specific fields in the document
    // var nombre = data['nombre'];
    // var descripcion = data['descripcion'];
    // var especie = data['especie'];
    // var urlImage = data['urlImage'];
    // var idProtectora = data['idProtectora'];
    // animales.pu(Pet.fromMap(data));
    animales[docSnapshot.id] = Pet.fromMap(data);
  }

  return animales;
}
