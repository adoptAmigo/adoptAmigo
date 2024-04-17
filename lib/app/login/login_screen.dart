import 'package:adopta_amigo/app/home/home.dart';
import 'package:adopta_amigo/app/login/function.dart';
import 'package:adopta_amigo/app/register/register_screen.dart';
import 'package:adopta_amigo/app/widgets.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  String email = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      FadeInUp(
                          duration: Duration(milliseconds: 1000),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeInUp(
                          duration: Duration(milliseconds: 1200),
                          child: Text(
                            "Accede a tu cuenta",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeInUp(
                          duration: Duration(milliseconds: 1200),
                          child: makeInput("Email", null, (text) {
                            email = text;
                          }),
                        ),
                        FadeInUp(
                          duration: Duration(milliseconds: 1300),
                          child: makeInput("Password", true, (text) {
                            password = text;
                          }),
                        ),
                      ],
                    ),
                  ),
                  FadeInUp(
                      duration: Duration(milliseconds: 1400),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
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
                              if (email.isEmpty && password.isEmpty) {
                                showToast("Email y contraseña son obligatorios",
                                    "info");
                              } else {
                                setState(() {
                                  isLoading = true;
                                });
                                  await login(email, password)
                                    .then((data) => {
                                          if (data)
                                            {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          HomeScreen()))
                                            }
                                          else
                                            {                                            
                                              setState(() {
                                                isLoading = false;
                                              })
                                            }
                                        })
                                    .catchError((error) {

                                  setState(() {
                                    isLoading = false;
                                  });

                                 // showToast("Login error", "error");
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
                                    "Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18),
                                  ),
                          ),
                        ),
                      )),
                  FadeInUp(
                      duration: Duration(milliseconds: 1500),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text("No tienes cuenta?"),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => RegisterScreen()));
                            },
                            child: Text('Registrar',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.black)),
                          ),
                        ],
                      ))
                ],
              ),
            ),
            FadeInUp(
                duration: Duration(milliseconds: 1200),
                child: Container(
                  height: MediaQuery.of(context).size.height / 3,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('background.png'),
                          fit: BoxFit.cover)),
                ))
          ],
        ),
      ),
    );
  }
}
