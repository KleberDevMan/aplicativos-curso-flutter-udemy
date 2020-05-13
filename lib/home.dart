import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx_fluterando/home_controller.dart';

class MyHomePage extends StatelessWidget {
  final homeController = HomeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MobX'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Observer(builder: (_) {
            return Text('${homeController.counter}',
                style: Theme.of(context).textTheme.display1);
          }),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          homeController.increment();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
