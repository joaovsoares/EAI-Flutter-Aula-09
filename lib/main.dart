import 'package:flutter/material.dart';
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var corPrincipal = Colors.blue;
    var titulo = 'Lista de Tarefas - EAI';

    return MaterialApp(
      title: titulo,
      darkTheme: ThemeData.dark().copyWith(primaryColor: corPrincipal),
      theme: ThemeData(
        primarySwatch: corPrincipal,
      ),
      home: MyHomePage(title: titulo),
      debugShowCheckedModeBanner: false,
    );
  }
}
