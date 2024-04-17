import 'package:adopta_amigo/app/home/home.dart';
import 'package:adopta_amigo/app/model/pet.dart';
import 'package:adopta_amigo/app/profile/function.dart';
import 'package:adopta_amigo/app/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:adopta_amigo/app/profile/collaborator_screen.dart';

class PetScreen extends StatelessWidget {
  const PetScreen({super.key, required this.uid});

  final uid;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: getInfoPet(uid),
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
                      children: [
                        CircleAvatar(
                          maxRadius: 65,
                          backgroundImage:
                              NetworkImage(snapshot.data!.urlImage),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Nombre : ${snapshot.data!.nombre}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Especie : ${snapshot.data!.especie}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                           snapshot.data!.descripcion,
                                style: TextStyle(fontSize: 20), softWrap: true)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [isAdoptedText(snapshot)],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: Expanded(
                          child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Card(
                            color: Colors.white70,
                            margin: const EdgeInsets.only(
                                left: 35, right: 35, bottom: 10),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              leading: Icon(
                                Icons.logout,
                                color: Colors.black54,
                              ),
                              title: Text(
                                'Perfil protectora',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                              onTap: () => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CollaboratorScreen(
                                                uid: snapshot
                                                    .data!.idProtectora)))
                              },
                            ),
                          ),
                          adoptPet(context, snapshot , uid)
                        ],
                      )),
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

  Card adoptPet(BuildContext context, AsyncSnapshot<Pet> snapshot , uid) {
    if (snapshot.data!.isAdopted) {
      return Card(
        color: Color.fromARGB(179, 74, 43, 229),
        margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.black54,
          ),
          title: Text(
            '${snapshot.data!.nombre} ya esta adoptado',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios_outlined)         
        ),
      );
    } else {
      return Card(
        color: Color.fromARGB(162, 25, 157, 56),
        margin: const EdgeInsets.only(left: 35, right: 35, bottom: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ListTile(
          leading: Icon(
            Icons.logout,
            color: Colors.black54,
          ),
          title: Text(
            'Adoptar a ${snapshot.data!.nombre}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          trailing: Icon(Icons.arrow_forward_ios_outlined),
          onTap: () => {
               setAdoption(uid).then((value) => {

                Navigator.push(
                context, MaterialPageRoute(builder: (context) => ProfileScreen()))
  

               })
          },
        ),
      );
    }
  }

  Text isAdoptedText(AsyncSnapshot<Pet> snapshot) {
    if (snapshot.data!.isAdopted) {
      return Text(
        "!Este amigo ya tiene un hogar¡",
        style: TextStyle(fontSize: 20),
      );
    } else {
      return Text(
        "Este amigo necesita un hogar, adoptalo!!! :",
        style: TextStyle(fontSize: 20),
      );
    }
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
