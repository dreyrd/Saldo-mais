import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'services/auth_service.dart';
import 'login.dart';
import 'package:intl/intl.dart';

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
  double gastosFixosTotal = 0.00;
  double gastosMesTotal = 0.00;
  double ganhosTotais = 0.0;


  void somarGastosFixos(double valor){
    setState(() {
      gastosFixosTotal += valor;
    });
  }

  void somarGastosMes(double valor){
    setState(() {
      gastosMesTotal += valor;
    });
  }

  void somarGanhosMes(double valor){
    setState(() {
      ganhosTotais += valor;
    });
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
                    return Text('Adicione um gasto fixo para aparecer aqui');
                  }
                  var dataList = snapshots.data!.docs;

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index){
                        var data = dataList[index].data() as Map<String, dynamic>;

                        var nome = data['nome'];

                        var dataHora = (data['data'] as Timestamp).toDate();
                        var dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);

                        var valor = data['valor'];
                        somarGastosFixos(valor);

                        return Row(
                          children: [
                            Text(nome.toString()),
                            SizedBox(width: 10),
                            Text(dataCompra.toString()),
                            SizedBox(width: 10),
                            Text(valor.toString()),
                          ],
                        );

                      }
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
      
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: dataList.length,
                  itemBuilder: (context, index){
                    var data = dataList[index].data() as Map<String, dynamic>;
      
                    var nome = data['nome'];
      
                    var dataHora = (data['data'] as Timestamp).toDate();
                    var dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);
      
                    var valor = data['valor'];
                    somarGastosMes(valor);
      
                    return Row(
                      children: [
                        Text(nome.toString()),
                        SizedBox(width: 10),
                        Text(dataCompra.toString()),
                        SizedBox(width: 10),
                        Text(valor.toString()),
                      ],
                    );
      
                  }
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
                builder: (contex, snapshots){

                  if(snapshots.connectionState == ConnectionState.waiting){
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if(!snapshots.hasData || snapshots.data!.docs.isEmpty){
                    return Text('Adicione seus ganhos do mês para aparecer aqui');
                  }
                  var dataList = snapshots.data!.docs;

                  return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: dataList.length,
                      itemBuilder: (context, index){
                        var data = dataList[index].data() as Map<String, dynamic>;

                        var nome = data['nome'];

                        var dataHora = (data['data'] as Timestamp).toDate();
                        var dataCompra = DateFormat('dd/MM/yyyy').format(dataHora);

                        var valor = data['valor'];
                        somarGanhosMes(valor);

                        return Row(
                          children: [
                            Text(nome.toString()),
                            SizedBox(width: 10),
                            Text(dataCompra.toString()),
                            SizedBox(width: 10),
                            Text(valor.toString()),
                          ],
                        );

                      }
                  );
                }
            ),
            SizedBox(height: 20),


            Text("Total mensal"),
            Row(
              children: [
                Text(rendaMensal.toString()),
                SizedBox(width: 5),
                Text("-"),
                SizedBox(width: 5),
                Text(gastosFixosTotal.toString()),
                SizedBox(width: 5),
                Text("-"),
                SizedBox(width: 5),
                Text(gastosMesTotal.toString()),
                SizedBox(width: 5),
                Text("+"),
                SizedBox(width: 5),
                Text(ganhosTotais.toString()),
                SizedBox(width: 5),
                Text("="),
                SizedBox(width: 5),
                Text((rendaMensal - gastosFixosTotal - gastosMesTotal + ganhosTotais).toString()),
              ],
            ),


          ],
        ),
      )
    );

  }
}
