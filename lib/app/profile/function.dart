import 'package:adoptAmigo/app/model/customer.dart';
import 'package:adoptAmigo/app/model/pet.dart';
import 'package:adoptAmigo/app/model/collaborator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';

Future<Customer> getInfoUser() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    try {
      final ref = FirebaseFirestore.instance.collection('usuarios');
      final res = await ref.where('email', isEqualTo: user.email).get();
      if (res.docs.isEmpty) throw Exception('No se encontró el usuario');
      final data = Customer.fromMap(res.docs[0].data());
      return data;
    } catch (e) {
      print("Error getting user: $e");
      rethrow; // Lanza la excepción para ser manejada por quien llama la función.
    }
  } else {
    throw Exception('No se encontro el usuario');
  }
}

Future<Pet> getInfoPet(String uid) async {
  try {
    final ref = FirebaseFirestore.instance.collection('animales');
    final docSnapshot = await ref.doc(uid).get();
    if (!docSnapshot.exists) throw Exception('No se encontró la mascota');
    final data = docSnapshot.data() as Map<String, dynamic>;
    return Pet.fromMap(data);
  } catch (e) {
    print("Error getting pet: $e");
    rethrow; // Lanza la excepción para ser manejada por quien llama la función.
  }
}

Future<Collaborator> getInfoCollaborator(String uid) async {
  try {
    final ref = FirebaseFirestore.instance.collection('protectoras');
    final docSnapshot = await ref.doc(uid).get();
    if (!docSnapshot.exists) throw Exception('No se encontró el colaborador');
    final data = docSnapshot.data() as Map<String, dynamic>;
    return Collaborator.fromMap(data);
  } catch (e) {
    print("Error getting collaborator: $e");
    rethrow; // Lanza la excepción para ser manejada por quien llama la función.
  }
}

Future<bool> setAdoption(String idAnimal) async {
  try {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Usuario no autenticado');

    final ref = FirebaseFirestore.instance.collection('adopciones');
    final data = {"id_animal": idAnimal, "id_usuario": user.uid};
    final documentSnapshot = await ref.add(data);

    if (documentSnapshot.id == "") return false;

    await updateAnimal(idAnimal);
    return true;
  } catch (e) {
    print("Error setting adoption: $e");
    return false;
  }
}

Future<void> updateAnimal(String idAnimal) async {
  final animales = FirebaseFirestore.instance.collection('animales');
  await animales.doc(idAnimal).update({"isAdopted": true});
}

Future<Map<dynamic, Pet>> getUserPetList() async {
  final db = FirebaseFirestore.instance;

  Map<dynamic, Pet> animales = {};

  final user = FirebaseAuth.instance.currentUser;

  //bsucamos en adopciones los ids de las mascotas
  final adopcionesRef = db.collection("adopciones");
  final usersPet =
      await adopcionesRef.where('id_usuario', isEqualTo: user!.uid).get();
  final petRef = FirebaseFirestore.instance.collection('animales');
  //  final data = Customer.fromMap(res.docs[0].data());
  //final res = await ref.where('email', isEqualTo: user.email).get();

  for (var docSnapshot in usersPet.docs) {
    final userPetData = docSnapshot.data();
    final id_animal = userPetData['id_animal'];
    var pet;

    await petRef.doc(id_animal).get().then(
      (DocumentSnapshot doc) {
        pet = doc.data() as Map<String, dynamic>;
      },
      onError: (e) => print("Error getting document: $e"),
    );
    // Access specific fields in the document
    // var nombre = data['nombre'];
    // var descripcion = data['descripcion'];
    // var especie = data['especie'];
    // var urlImage = data['urlImage'];
    // var idProtectora = data['idProtectora'];
    // animales.pu(Pet.fromMap(data));
    animales[id_animal] = Pet.fromMap(pet);
  }

  return animales;
}
