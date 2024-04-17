import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget makeInput(
      String label, bool? obscureText, void Function(String)? onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
        ),
        SizedBox(
          height: 5,
        ),
        TextField(
          obscureText: obscureText ?? false,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)),
          ),
          onChanged: onChanged,
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

void showToast(String mensaje , String type) {

  String backgroundColor = "";

  if(type == "warning"){

    backgroundColor ="#dbe649";

  }else if(type == "info"){

 backgroundColor = "#0f2a6e";

  }else if (type =="error"){

    backgroundColor = "#e01f1f";

  }else if(type == "success"){

    backgroundColor = "#81e38d";
  }

  Fluttertoast.showToast(
    msg: mensaje,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,   
    textColor: Colors.white,
    webBgColor : backgroundColor,
  );
  
}