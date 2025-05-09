import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:financias/home.dart';
import 'package:financias/login.dart';


class AuthService {


  Future<void> signup({required String email, required String password, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      await Future.delayed(const Duration(milliseconds: 100));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => LoginPage())
      );

    }
    on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'weak-password') {
        message = 'A senha é muito fraca';
      }
      else if (e.code == 'email-already-in-use') {
        message = 'O email já está em uso';
      }
      else if (e.code == 'invalid-email') {
        message = 'O email é inválido';
      }
      else {
        message = 'Erro ao cadastrar usuário';
      }

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 14.0
      );
    }
    catch (e){
      print(e);
    }
  }

  Future<void> signin({required String email, required String password, required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );

      await Future.delayed(const Duration(milliseconds: 100));

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (BuildContext context) => HomePage())
      );
    }
    on FirebaseAuthException catch (e) {
      String message = "";

      if (e.code == 'user-not-found') {
        message = 'Usuario não encontrado';
      }
      else if (e.code == 'wrong-password') {
        message = 'Senha incorreta';
      }
      else{
        message = 'Erro ao fazer login';
      }

      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.SNACKBAR,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 14.0
      );

    }
    catch (e){
      print(e);
    }
  }
}


