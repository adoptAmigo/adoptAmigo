import 'package:adopta_amigo/app/profile/pet_screen.dart';
import 'package:adopta_amigo/app/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:adopta_amigo/app/home/function.dart';
import 'package:adopta_amigo/app/model/pet.dart';
import 'package:adopta_amigo/app/collaborators/collaborators_screen.dart';

final List<String> _menuItems = <String>['Home', 'Perfil', 'Protectoras'];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PetList();
  }
}

class PetList extends StatelessWidget {
  PetList({Key? key}) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(182, 14, 172, 116),
          elevation: 0,
          titleSpacing: 1,
          leading: isLargeScreen
              ? null
              : IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                ),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('../assets/logo_2.png',
                    height: 75, fit: BoxFit.contain)
              ],
            ),
          ),
        ),
        drawer: isLargeScreen ? null : DrawerMenu(scaffoldKey: _scaffoldKey),
        body: MainListPets(),
      ),
    );
  }
}

class MainListPets extends StatelessWidget {
  const MainListPets({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<dynamic, Pet>>(
        future: getPetList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (snapshot.hasData) {
            return Center(
              child: Container(               
                constraints: const BoxConstraints(maxWidth: 400),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    final item = snapshot.data;
                    var data = item!.entries.toList();
                    return Container(
                      height: 200,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Color.fromARGB(255, 57, 89, 179)),
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.all(8),
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
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "${data[index].value.especie} -  ${data[index].value.descripcion}",
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                )
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
                ),
              ),
            );
          }

          return CircularProgressIndicator();
        });
  }
}

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key, required GlobalKey<ScaffoldState> scaffoldKey})
      : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: _menuItems
              .map((item) => ListTile(
                    onTap: () {
                      if (item == "Perfil") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      } else if (item == "Home") {
                        Navigator.pop(context);
                      } else if (item == "Protectoras") {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CollaboratorsScreen()));
                      }
                    },
                    title: Text(item),
                  ))
              .toList(),
        ),
      );
}
