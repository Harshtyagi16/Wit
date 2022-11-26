import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Auth with ChangeNotifier{
String? idToken;
String? userId;


  Future<void> signUp(String email,String password) async {
  final signupUrl = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCSlqSB5RHhNgVq7-11Zjiv23VWF6y5QWM');
  try{
    final request = await http.post(signupUrl,body: {
      "email" : email,
      "password" : password,
      "returnSecureToken" : "true"
    });
    notifyListeners();
  }catch(e){
    print(e);
  }
  }

Future<void> login(String email,String password) async{
  final loginUrl = Uri.parse('https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCSlqSB5RHhNgVq7-11Zjiv23VWF6y5QWM');
  try{
    final request = await http.post(loginUrl,body: {
      "email":email,
      "password": password,
      "returnSecureToken" : "true",
    });

    if(request.statusCode == 200){
      final responseBody =  jsonDecode(request.body);
      print("login data$responseBody");
      idToken = responseBody["idToken"];
      userId = responseBody["localId"];
    }
    notifyListeners();


  }catch(e){
    print(e);
  }
}

// void logout(){
//   final responseBody = jsonDecode(request.body);
//     print('SignUp $responseBody');
//
//   }
}