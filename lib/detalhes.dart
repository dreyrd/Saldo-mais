import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


class DetalhesPage extends StatefulWidget {
  final String id_item;
  final Map<String, dynamic> item;

  const DetalhesPage({super.key, required this.id_item, required this.item});

  @override
  State<DetalhesPage> createState() => _DetalhesPageState();
}


class _DetalhesPageState extends State<DetalhesPage> {
  late DateTime dataHora;
  late String dataCompra;

  @override
  void initState() {
    super.initState();
    dataHora = (widget.item['data'] as Timestamp).toDate();
    dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);
  }

  void excluir(){
    FirebaseFirestore.instance.collection('saldo-mais').doc(widget.id_item).delete().then((value) {
      Navigator.pop(context);
    }).catchError((error) {
      print("Erro ao excluir: $error");
    });
  }
  

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
          Text(widget.item['nome']),

          SizedBox(height: 30),
          Text(widget.item['valor'].toString()),

          SizedBox(height: 30),
          Text("Descrição"),

          SizedBox(height: 30),
          Text(dataCompra),

          SizedBox(height: 30),
          ElevatedButton(
            onPressed: (){
              excluir();
            },
            child: Text("Excluir")
          )
        ],
      ),
    );
  }
}
