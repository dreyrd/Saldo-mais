import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/auth_service.dart';

// https://coolors.co/0c1618-004643-faf4d3-d1ac00-f6be9a


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void printar(){
    print(_emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Color(0xff0c1618),
      
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Text(
              "Saldo+",
              style: TextStyle(
                color: Colors.white,
                fontSize: 50,
             )
            ),

            SizedBox(height: 40),

            TextField(
              style: TextStyle(color: Colors.white),
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text("Digite seu email"),
              ),
            ),

            TextField(
              style: TextStyle(color: Colors.white),
              controller: _passwordController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text("Digite sua senha"),
              ),
            ),

            ElevatedButton(
                onPressed: () =>{
                  AuthService().signin(
                      email: _emailController.text,
                      password: _passwordController.text,
                      context: context
                  )
                },
                child: Text("Login")
            ),
          ],
        ),
      )
    );
  }
}
