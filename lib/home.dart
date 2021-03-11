import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'tarefarepository.dart';
import 'tarefa.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tarefa> _tarefas = [];

  void carregarTarefas() async {
    var repositorio = new TarefaRepository();
    var tarefasSalvas = await repositorio.obter();

    setState(() {
      _tarefas.addAll(tarefasSalvas);
    });
  }

  void gravarTarefas() async {
    var repositorio = new TarefaRepository();
    await repositorio.salvar(_tarefas);
  }

  @override
  void initState() {
    super.initState();

    carregarTarefas();
  }

  void adicionarTarefa(String tarefa) {
    setState(() {
      _tarefas.add(new Tarefa(nome: tarefa));

      gravarTarefas();
    });
  }

  void _removerTarefa(int index) {
    setState(() {
      _tarefas.removeAt(index);

      gravarTarefas();
    });
  }

  AppBar appBar(String titulo) {
    return AppBar(
        title: Text(widget.title),
      );
  }

  Widget tarefa(String textoTarefa, int index) {
    return new ListTile(
      title: new Text(textoTarefa),
      onTap: () => pergutarParaRemoverTarefa(index)
    );
  }

  Widget listaDeTarefas() {
    return new ListView.builder(
      itemBuilder: (context, index) {
        if(index < _tarefas.length) {
          return tarefa(_tarefas[index].nome, index);
        }
      },
    );
  }

  void abrirTelaParaAdicionarTarefa() {
    Navigator.of(context).push(
      // MaterialPageRoute will automatically animate the screen entry, 
      // as well as adding a back button to close it
      new MaterialPageRoute(
        builder: (context) {
          return new Scaffold(
            appBar: new AppBar(
              title: new Text('Adicione uma tarefa')
            ),
            body: new TextField(
              autofocus: true,
              keyboardType: TextInputType.text,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.singleLineFormatter
              ],
              onSubmitted: (valor) {
                adicionarTarefa(valor);
                Navigator.pop(context); // Close the add todo screen
              },
              decoration: new InputDecoration(
                hintText: 'Digite o nome da tarefa...',                
                contentPadding: const EdgeInsets.all(16.0)
              ),
            )
          );
        }
      )
    );
  }

  FloatingActionButton botaoAdicionar() {
    return FloatingActionButton(
        onPressed: abrirTelaParaAdicionarTarefa,
        tooltip: 'Adicionar',
        child: Icon(Icons.add)
    );
  }

  void pergutarParaRemoverTarefa(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Remover tarefa "${_tarefas[index].nome}"?'),
          actions: <Widget>[
            new FlatButton(
              child: new Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop()
            ),
            new FlatButton(
              child: new Text('Sim, por favor!'),
              onPressed: () {
                _removerTarefa(index);
                Navigator.of(context).pop();
              }
            )
          ]
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(widget.title),
      body: listaDeTarefas(),
      floatingActionButton: botaoAdicionar(),
    );
  }
}