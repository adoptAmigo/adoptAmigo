import 'package:adoptAmigo/app/home/home.dart';
import 'package:adoptAmigo/app/profile/function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adoptAmigo/app/login/login_screen.dart';

class CollaboratorScreen extends StatelessWidget {
  const CollaboratorScreen({super.key, required this.uid});

  final uid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: getInfoCollaborator(uid),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: Colors.white54,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const ListTile(leading: BackButton()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircleAvatar(
                          maxRadius: 65,
                          backgroundImage: AssetImage("assets/iprofile.jpg"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          snapshot.data!.nombre,
                          style: TextStyle(
                              fontWeight: FontWeight.w900, fontSize: 26),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Contactos : ${snapshot.data!.contacto}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(36.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Ubicación :  ${snapshot.data!.ubicacion}",
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  const BackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      highlightColor: Colors.pink,
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      },
    );
  }
}

Future _signOut(context) async {
  await FirebaseAuth.instance.signOut().then((value) => Navigator.of(context)
      .pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          (route) => false));
}
