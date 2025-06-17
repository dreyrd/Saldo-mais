import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/auth_service.dart';
import 'login.dart';
import 'package:intl/intl.dart';
import 'detalhes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    getUid();
  }

  var uid = "";
  double rendaMensal = 1790.00;

  void abrirDetalhes(id_item, item){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DetalhesPage(id_item: id_item, item: item))
    );
  }

  void getUid(){

    try{
      final currentUid = AuthService().getUserUid();
      setState(() {
        uid = currentUid;
      });
    }
    catch(e){
      print(e);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage())
      );
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30),
            Text("Gastos fixos"),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('saldo-mais')
                  .where('uid_usuario', isEqualTo: uid)
                  .where('tipo', isEqualTo: 'fixo')
                  .snapshots(),
              builder: (contex, snapshots){

                if(snapshots.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                  return Text('Adicione seus gastos fixos do mês para aparecer aqui');
                }
                var dataList = snapshots.data!.docs;


                double total = dataList.fold(0.0, (prev, doc){
                  var data = doc.data() as Map<String, dynamic>;
                  var valor = (data['valor'] as num).toDouble();
                  return prev + valor;
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index){
                        var id = dataList[index].id;
                        var data = dataList[index].data() as Map<String, dynamic>;

                        var nome = data['nome'];

                        var dataHora = (data['data'] as Timestamp).toDate();
                        var dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);

                        var valor = data['valor'];

                        return ElevatedButton(
                          onPressed: () => abrirDetalhes(id, data),
                          child: Row(
                            children: [
                              Text(nome.toString()),
                              SizedBox(width: 10),
                              Text(dataCompra.toString()),
                              SizedBox(width: 10),
                              Text(valor.toString()),
                            ],
                          )
                        );

                      }
                    ),

                    Text("Total: $total")

                  ],
                );
              }
            ),
            SizedBox(height: 20),


            Text("Gastos do mês"),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('saldo-mais')
                  .where('uid_usuario', isEqualTo: uid)
                  .where('tipo', isEqualTo: 'gasto')
                  .snapshots(),
              builder: (contex, snapshots){
      
                if(snapshots.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
      
                if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                  return Text('Adicione um gasto do mês para aparecer aqui');
                }
                var dataList = snapshots.data!.docs;

                double total = dataList.fold(0.0, (prev, doc){
                  var data = doc.data() as Map<String, dynamic>;
                  var valor = (data['valor'] as num).toDouble();
                  return prev + valor;
                });
      
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index){
                        var id = dataList[index].id;
                        var data = dataList[index].data() as Map<String, dynamic>;

                        var nome = data['nome'];

                        var dataHora = (data['data'] as Timestamp).toDate();
                        var dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);

                        var valor = data['valor'];

                        return ElevatedButton(
                          onPressed: () => abrirDetalhes(id, data),
                          child: Row(
                            children: [
                              Text(nome.toString()),
                              SizedBox(width: 10),
                              Text(dataCompra.toString()),
                              SizedBox(width: 10),
                              Text(valor.toString()),
                            ],
                          )
                        );

                      }
                    ),

                    Text("Total: $total"),

                  ],
                );
              }
            ),
            SizedBox(height: 20),


            Text("Ganhos"),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('saldo-mais')
                  .where('uid_usuario', isEqualTo: uid)
                  .where('tipo', isEqualTo: 'ganho')
                  .snapshots(),
              builder: (context, snapshots){

                if(snapshots.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                  return Text('Adicione seus ganhos do mês para aparecer aqui');
                }

                var dataList = snapshots.data!.docs;


                double total = dataList.fold(0.0, (prev, doc){
                  var data = doc.data() as Map<String, dynamic>;
                  var valor = (data['valor'] as num).toDouble();
                  return prev + valor;
                });

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [


                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index){
                        var id = dataList[index].id;
                        var data = dataList[index].data() as Map<String, dynamic>;

                        var nome = data['nome'];

                        var dataHora = (data['data'] as Timestamp).toDate();
                        var dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);

                        var valor = data['valor'];

                        return ElevatedButton(
                          onPressed: () => abrirDetalhes(id, data),
                          child: Row(
                            children: [
                              Text(nome.toString()),
                              SizedBox(width: 10),
                              Text(dataCompra.toString()),
                              SizedBox(width: 10),
                              Text(valor.toString()),
                            ],
                          )
                        );

                      }
                    ),

                    Text("Total: $total"),

                  ],
                );
              }
            ),
            SizedBox(height: 20),


            Text("Total mensal"),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('saldo-mais')
                  .where('uid_usuario', isEqualTo: uid)
                  .snapshots(),
              builder: (context, snapshots){

                double gastosFixosTotal = 0.0;
                double gastosMesTotal = 0.0;
                double ganhosTotais = 0.0;

                if(snapshots.connectionState == ConnectionState.waiting){
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                var dataList = snapshots.data!.docs;

                for(var doc in dataList){
                  var data = doc.data() as Map<String, dynamic>;
                  var tipo = data['tipo'];
                  var valor = (data['valor'] as num).toDouble();


                  if(tipo == 'fixo'){
                    gastosFixosTotal += valor;
                  }
                  else if(tipo == 'gasto'){
                    gastosMesTotal += valor;
                  }
                  else if(tipo == 'ganho') {
                    ganhosTotais += valor;
                  }
                }

                double totalMensal = rendaMensal - gastosFixosTotal - gastosMesTotal + ganhosTotais;

                return Row(
                  children: [
                    Text(rendaMensal.toStringAsFixed(2)),
                    SizedBox(width: 5),
                    Text("-"),
                    SizedBox(width: 5),
                    Text(gastosFixosTotal.toStringAsFixed(2)),
                    SizedBox(width: 5),
                    Text("-"),
                    SizedBox(width: 5),
                    Text(gastosMesTotal.toStringAsFixed(2)),
                    SizedBox(width: 5),
                    Text("+"),
                    SizedBox(width: 5),
                    Text(ganhosTotais.toStringAsFixed(2)),
                    SizedBox(width: 5),
                    Text("="),
                    SizedBox(width: 5),
                    Text(totalMensal.toStringAsFixed(2)),
                  ],
                );

              }
            )



          ],
        ),
      )
    );

  }
}
