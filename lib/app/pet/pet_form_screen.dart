// ignore_for_file: library_private_types_in_public_api

import 'package:adoptAmigo/app/pet/function.dart';
import 'package:adoptAmigo/app/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

String collaborator = "";

class PetFormScreen extends StatefulWidget {
  @override
  State<PetFormScreen> createState() => _PetFormScreenState();
}

class _PetFormScreenState extends State<PetFormScreen> {
  bool isLoading = false;
  String nombre = '';
  String especie = '';
  String descripcion = '';
  // TODO : String imagen = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),           
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    FadeInUp(
                        duration: Duration(milliseconds: 1000),
                        child: Text(
                          "Registro de animales",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                Column(
                  children: <Widget>[
                    FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: makeInput("Nombre", null, (text) {
                        nombre = text;
                      }),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: makeInput("Descripcion", null, (text) {
                        descripcion = text;
                      }),
                    ),
                    FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: makeInput("Especie", null, (text) {
                        especie = text;
                      }),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(children: [FadeInUp(child: CollaboratorWidget())]),
                SizedBox(
                  height: 20,
                ),
                FadeInUp(
                    duration: Duration(milliseconds: 1500),
                    child: Container(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border(
                            bottom: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            left: BorderSide(color: Colors.black),
                            right: BorderSide(color: Colors.black),
                          )),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          if (nombre.isEmpty &&
                              especie.isEmpty &&
                              collaborator.isEmpty) {
                            showToast(
                                "Todos los campos obligatorios", "warning");
                          } else {
                            setState(() {
                              isLoading = true;
                            });

                            await addAnimal(
                                    nombre, especie, descripcion, collaborator)
                                .then((data) => {Navigator.pop(context)})
                                .catchError((error) {
                              setState(() {
                                isLoading = false;
                              });
                              showToast(
                                  "Error al registrar el animal", "error");
                            });
                          }
                        },
                        color: Colors.greenAccent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "Añadir animal",
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18),
                              ),
                      ),
                    )),
                FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage('assets/images/logo1.jpg'),
                              fit: BoxFit.scaleDown)),
                    ))
              ],
            ),
          ),
        ));
  }
}

class CollaboratorWidget extends StatefulWidget {
  @override
  _CollaboratorWidgetState createState() => _CollaboratorWidgetState();
}

class _CollaboratorWidgetState extends State<CollaboratorWidget> {
  String? _selectedCollaboratorName;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: getCollaborator(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); 
        }

        if (snapshot.hasError) {
          return Text(
              'Error: ${snapshot.error}'); 
        }

        List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
            snapshot.data!.docs;

        return DropdownButton<String>(
          hint: Text(
              'Seleccione protectora...'), 
          value: _selectedCollaboratorName,
          onChanged: (String? newValue) {},
          items:
              documents.map((DocumentSnapshot<Map<String, dynamic>> document) {
            var collaboratorData = document.data() ??
                {}; // Get collaborator data from the document
            var collaboratorName = collaboratorData['nombre'] ??
                'Unknown'; 
            return DropdownMenuItem<String>(
              onTap: () {
                setState(() {
                  collaborator = document.id;
                  _selectedCollaboratorName = collaboratorData['nombre'];
                });
              },
              value: collaboratorData[
                  'nombre'], 
              child: Text(
                  collaboratorName), 
            );
          }).toList(),
        );
      },
    );
  }
}
