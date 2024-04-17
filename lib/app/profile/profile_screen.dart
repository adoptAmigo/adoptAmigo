import 'package:adopta_amigo/app/home/home.dart';
import 'package:adopta_amigo/app/profile/function.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:adopta_amigo/app/login/login_screen.dart';
import 'package:adopta_amigo/app/profile/pet_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: FutureBuilder(
          future: getInfoUser(),
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
                          backgroundImage: AssetImage("iprofile.jpg"),
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
                          snapshot.data!.email,
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
                          "Nombre : ${snapshot.data!.nombre}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Apellido : ${snapshot.data!.apellido}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Telefono :  ${snapshot.data!.telefono}",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
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
                                'Logout',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios_outlined),
                              onTap: () => {_signOut(context)},
                            ),
                          )
                        ],
                      )),
                    ),
                   Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Amigos adoptados",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    ),
                    Expanded(child: petListView())
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

  Widget petListView() {
    return SizedBox(
        height: 120,
        child: FutureBuilder(
            future: getUserPetList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
               return ListView.builder(
                  itemCount: snapshot.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final item = snapshot.data;
                    var data = item!.entries.toList();
                    return Container(
                      margin: EdgeInsets.all(12),
                      height: 100,
                      width: 200,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PetScreen(uid: data[index].key)));
                        },
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index].value.nombre,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                    "${data[index].value.especie} -  ${data[index].value.descripcion}",
                                    style:
                                        Theme.of(context).textTheme.bodySmall)
                              ],
                            )),
                            Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(8.0),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          data[index].value.urlImage),
                                    ))),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              return CircularProgressIndicator();
            }));
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
