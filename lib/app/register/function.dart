import 'package:adopta_amigo/app/model/customer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


Future register(String email, String password, String nombre, String apellido,
    String telefono) async {
 
    Customer customer = getCustomer(nombre, apellido, telefono, email);

    FirebaseFirestore firestore = FirebaseFirestore.instance;
    FirebaseAuth auth = FirebaseAuth.instance;

    UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = userCredential.user;

    if (user != null) {
      await firestore
          .collection('usuarios')
          .doc(user.uid)
          .set(customer.toMap());
      return true;
    } else {
      return false;
    }

}

Customer getCustomer(
    String nombre, String apellido, String telefono, String email) {
  final data = Customer(
    nombre: nombre,
    apellido: apellido,
    email: email,
    telefono: telefono,
    fechaRegistro:
        DateFormat("yyyy-MM-dd").add_jm().format(DateTime.now()).toString(),
  );

  return data;
}


