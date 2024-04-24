import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adoptAmigo/app/model/pet.dart';

final db = FirebaseFirestore.instance;

Future addAnimal(String nombre, String especie, String descripcion,
    String collaborator) async {
  Pet pet = Pet(
      nombre: nombre,
      descripcion: descripcion,
      especie: especie,
      isAdopted: false,
      urlImage: "",
      idProtectora: collaborator);
  await db.collection('animales').add(pet.toMap());
}

Stream<QuerySnapshot<Map<String, dynamic>>> getCollaborator() {
  final db = FirebaseFirestore.instance;

  // Return a stream of query snapshots
  return db.collection("protectoras").snapshots();
}
