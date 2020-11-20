import 'package:flutter/material.dart';

class DrawerApp extends StatefulWidget {

  DrawerApp({ this.route });
  /*final String name = 'Leonardo Mendes';
  final String email = "l.mendes@gmail.com";*/
  final String route;
  
  @override
  _DrawerAppState createState() => _DrawerAppState();
}

class _DrawerAppState extends State<DrawerApp> {
  
  @override
  Drawer build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              child: Text(''),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  image: AssetImage('assets/original/bg.jpg'),
                     fit: BoxFit.cover)
              ),
            ),
          ListTile(
            leading: Icon(Icons.list),
            selected: (widget.route == '/listagem_robo'),
            title: Text('Robôs'),
            onTap: () {
              Navigator.of(context)
               .pushNamedAndRemoveUntil('/listagem_robo', (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.add),
            selected: (widget.route == '/cadastro_robo'),
            title: Text('Cadastro Robô'),
            onTap: () {
              Navigator.pushNamed(
                context, 
                '/cadastro_robo'
              );
            },
          ),
        ],
      ),
    );
  }
}