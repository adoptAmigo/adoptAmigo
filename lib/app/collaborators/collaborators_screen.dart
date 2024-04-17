import 'package:adopta_amigo/app/home/home.dart';
import 'package:adopta_amigo/app/profile/collaborator_screen.dart';
import 'package:adopta_amigo/app/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:adopta_amigo/app/collaborators/functions.dart';
import 'package:adopta_amigo/app/model/collaborator.dart';

final List<String> _menuItems = <String>['Home', 'Pefil', 'Protectoras'];

class CollaboratorsScreen extends StatefulWidget {
  @override
  State<CollaboratorsScreen> createState() => _CollaboratorsScreenState();
}

class _CollaboratorsScreenState extends State<CollaboratorsScreen> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CollaboratorList();
  }
}

class CollaboratorList extends StatelessWidget {
  CollaboratorList({Key? key}) : super(key: key);

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
            backgroundColor: Colors.transparent,
            elevation: 0,
            titleSpacing: 0,
            leading: isLargeScreen
                ? null
                : IconButton(
                    icon: const Icon(Icons.menu),
                    onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                  ),
            title: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 11.0),
              child: AspectRatio(
                aspectRatio: 4,
                child: Image.asset('../assets/logo_2.png'),
              ),
            )),
        drawer: isLargeScreen ? null : DrawerMenu(scaffoldKey: _scaffoldKey),
        body: MainListCollaborators(),
      ),
    );
  }
}

class MainListCollaborators extends StatelessWidget {
  const MainListCollaborators({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<dynamic, Collaborator>>(
        future: getCollaboratorList(),
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
                      height: 136,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFFE0E0E0)),
                          borderRadius: BorderRadius.circular(8.0)),
                      padding: const EdgeInsets.all(8),
                      child: 
                      GestureDetector(
                        onTap: () {
                       Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CollaboratorScreen(uid : data[index].key)));
                               
                        },
                        child:Row(
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
                              Text("${data[index].value.contacto} -  ${data[index].value.ubicacion}",
                                  style: Theme.of(context).textTheme.bodySmall),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icons.bookmark_border_rounded,
                                  Icons.share,
                                  Icons.more_vert
                                ].map((e) {
                                  return InkWell(
                                    onTap: () {},
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(e, size: 16),
                                    ),
                                  );
                                }).toList(),
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
                                    image: NetworkImage(data[index].value.urlImage),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      }else if(item == "Protectoras"){
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
