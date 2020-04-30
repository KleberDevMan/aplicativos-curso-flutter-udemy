import 'package:flutter/material.dart';

// todo projeto inicia aqui, no main
void main() {
  // passando a tela home
  runApp(MaterialApp(title: 'Contado de pessoas', home: Home()));
}

// tela statica = state_less = nao possuem state (estado interno)
// tela dinamica = state_full = possuem state (estado interno)
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// estado interno da minha tela home
class _HomeState extends State<Home> {
  // underline faz com que a variável só possa ser acessada aqui dentro do meu estado (privada)
  int _people = 0;
  String _infoText = "Pode entrar!";

// underline == funcao privada
  void _changePeople(int delta) {
    // executa o que esta dentro >> recarrega todo estado (refazendo apenas as partes modificadas)
    setState(() {
      _people += delta;

      if (_people < 0) {
        _infoText = 'Mundo invertido?!';
      } else if (_people <= 10) {
        _infoText = 'Pode entrar!';
      } else {
        _infoText = 'Lotado!';
      }
    });
  }

  // é chamada quando vamos modificar o layout
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          "images/restaurante.jpg",
          fit: BoxFit.cover,
          height: 1000,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Pessoas: $_people',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text(
                      "+1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changePeople(1);
                      // debugPrint('+1');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: FlatButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                      _changePeople(-1);
                    },
                  ),
                )
              ],
            ),
            Text(
              _infoText,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0),
            )
          ],
        )
      ],
    );
  }
}
