import 'package:flutter/material.dart';


class DetalhesPage extends StatefulWidget {
  const DetalhesPage({super.key});

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}


class _DetalhesPageState extends State<DetalhesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: Text("Voltar")
          ),

          SizedBox(height: 30),
          Text("Produto X"),

          SizedBox(height: 30),
          Text("Total pago"),

          SizedBox(height: 30),
          Text("Descrição"),

          SizedBox(height: 30),
          Text("Data"),
        ],
      ),
    );
  }
}
