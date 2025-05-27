import 'package:flutter/material.dart';
import 'home.dart';
import 'conta.dart';
import 'cadastro.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int index = 0;

  static List<Widget> pages = <Widget>[
    HomePage(),
    CadastroPage(),
    ContaPage()
  ];

  void showItemTrap(int selectIndex){
    setState(() {
      index = selectIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: pages.elementAt(index),
      ),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          hoverColor: Colors.transparent,
        ),
        child: Container(
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add_circle),
                label: 'Adicionar',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.people),
                label: 'Conta',
              ),
            ],
            currentIndex: index,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            onTap: showItemTrap,
          ),
        )
      ),

    );
  }
}
