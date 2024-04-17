import 'package:adopta_amigo/app/home/home.dart';
import 'package:adopta_amigo/app/register/function.dart';
import 'package:adopta_amigo/app/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;
  String nombre = '';
  String apellido = '';
  String email = '';
  String telefono = '';
  String password = '';
  String confirmPassword = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeInUp(
                      duration: Duration(milliseconds: 1000),
                      child: Text(
                        "Registro",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1200),
                      child: Text(
                        "Crea una cuenta, es gratis!",
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      )),
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
                    child: makeInput("Apellidos", null, (text) {
                      apellido = text;
                    }),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: makeInput("E-mail", null, (text) {
                      email = text;
                    }),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1200),
                    child: makeInput("Telefono", null, (text) {
                      telefono = text;
                    }),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1300),
                    child: makeInput("Contraseña", null, (text) {
                      password = text;
                    }),
                  ),
                  FadeInUp(
                    duration: Duration(milliseconds: 1400),
                    child: makeInput("Confirmar contraseña", null, (text) {
                      confirmPassword = text;
                    }),
                  ),
                ],
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
                        if (email.isEmpty &&
                            password.isEmpty &&
                            confirmPassword.isEmpty) {
                          showToast(
                              "Email y contraseña son obligatorios", "warning");
                        } else if (password != confirmPassword) {
                          showToast(
                              "La contraseña y la confirmación no son iguales",
                              "warning");
                        } else {
                          setState(() {
                            isLoading = true;
                          });

                          await register(
                                  email, password, nombre, apellido, telefono)
                              .then((data) => {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => HomeScreen()))
                                  })
                              .catchError((error) {
                            setState(() {
                              isLoading = false;
                            });

                            showToast("Error al registrar el usuario", "error");
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
                              "Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            ),
                    ),
                  )),
              FadeInUp(
                  duration: Duration(milliseconds: 1600),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?"),
                      // todo: poner TextButton
                         TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black)),
                          ),
                      
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
