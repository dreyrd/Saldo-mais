import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String nome = "";
  DateTime dataHora = DateTime.now();
  double valor = 0.0;

  void fetchData(){
    FirebaseFirestore.instance.collection('saldo-mais').snapshots().listen((snapshot) {
      var data = snapshot.docs.first.data();
      setState(() {

        print(data['nome']);
        print(data['data']);
        print(data['valor']);


        nome = data['nome'];
        dataHora = (data['data'] as Timestamp).toDate();
        valor = data['valor'];
      });
    });
  }


  @override
  void initState() {
    super.initState();
    fetchData();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: builder
    );

  }
}
