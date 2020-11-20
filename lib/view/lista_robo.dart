import 'package:chap_flutter/component/card_robo.dart';
import 'package:chap_flutter/component/drawer_app.dart';
import 'package:chap_flutter/model/robo.dart';
import 'package:chap_flutter/repository/robo_repository.dart';
import 'package:flutter/material.dart';

class ListaRobo extends StatefulWidget {
  @override
  _ListaRoboState createState() => _ListaRoboState();
}

class _ListaRoboState extends State<ListaRobo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Robôs')
      ),
      drawer: DrawerApp(
        route: '/listagem_robo',
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(
            context, 
            '/cadastro_robo'
          );
        },
      ),
      body: Center(
        child: FutureBuilder<List<Robo>>(
          future: RoboRepository.getAll(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return listagemRobos(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget listagemRobos(List<Robo> robos) {
    return ListView.builder(
      itemCount: robos.length,
      itemBuilder: (context, index) {
        return CardRobo(
          robo: robos[index],
          onTap: () {
            Navigator.pushNamed(context, '/chatbot');
          },
          onDismissed: (direction) {
            setState(() {});
          },
        );
      }
    );
  }
}