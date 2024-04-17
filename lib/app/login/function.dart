import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopta_amigo/app/widgets.dart';

Future<bool> login(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch (e) {

    showToast(e.message.toString(), "error"); 
   
  }
  return false;
}
