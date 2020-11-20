import 'package:chap_flutter/model/cor_robo.dart';
import 'package:chap_flutter/model/robo.dart';
import 'package:chap_flutter/repository/robo_repository.dart';
import 'package:flutter/material.dart';

class CadastroRobo extends StatefulWidget {
  @override
  _CadastroRoboState createState() => _CadastroRoboState();
}

class _CadastroRoboState extends State<CadastroRobo> {

  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Robo robo = new Robo();
  CorRobo cor = new CorRobo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Cadastrar Robô'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: FlatButton(
              textColor: Colors.white,
              onPressed: () {
                if (formKey.currentState.validate()) {
                  formKey.currentState.save();
                  try {
                    save();
                  } catch(e) {
                    scaffoldKey.currentState.showSnackBar(
                      SnackBar(
                        content: Text(
                          'Ocorreu um erro ao salvar o contrato'
                        ),
                      ),
                    );
                  }
                } else {
                  scaffoldKey.currentState.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Corrija os erros e tente novamente'
                      ),
                    ),
                  );
                }
              },
              child: Icon(Icons.save),
              shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
            ),
          ),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Column(
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      sectionRobo(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
    );
  }

  void save() async {
    await RoboRepository.save(robo);
    Navigator.of(context)
      .pushNamedAndRemoveUntil('/listagem_robo', (Route<dynamic> route) => false);
  }

  Widget sectionRobo() {
    return Column(
      children: <Widget>[
        sectionTitle(
          title: 'Informações do Robô'
        ),
        txtNome(),
        txtCor(cor),
      ],
    );
  }

  Widget sectionTitle({ title: String }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  TextFormField txtNome() {
    return TextFormField(
      decoration: new InputDecoration(
        icon: const Icon(Icons.work),
        hintText: 'Digite o nome do robô',
        labelText: 'Nome',
      ),
      validator: (nome) {
        if (nome.isEmpty) {
          return 'É necessário informar o nome do robô';
        }
        return null;
      },
      onSaved: (nome) {
        robo.nome = nome;
      },
    );
  }

  DropdownButtonFormField txtCor(CorRobo cor) {
    return DropdownButtonFormField(
      value: cor.id,
      items: CorRobo.getCores().map<DropdownMenuItem>((CorRobo cor) => DropdownMenuItem(
        child: Text("${cor.nome} ${cor.id}"),
        value: cor.id,
      )).toList(),
      decoration: new InputDecoration(
        alignLabelWithHint: true,
        icon: const Icon(Icons.palette),
        labelText: 'Cor',
      ),
      onSaved: (id) async {
        robo.cor = CorRobo.getColorById(id);
      },
      onChanged: (id) {
        setState(() => {
          cor = CorRobo.getColorById(id)
        });
      },
      validator: (cor) {
        if (cor == null) {
          return 'Selecione a cor';
        }
        return null;
      },
    );
  }
}