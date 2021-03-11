//pubspec.yaml
//dependencies:
//shared_preferences: ^0.5.12+4

import 'package:shared_preferences/shared_preferences.dart';
import 'tarefa.dart';

class TarefaRepository {
  static const listaDeTarefasKey = 'listaDeTarefas';

  Future<List<Tarefa>> obter() async {
    final prefs = await SharedPreferences.getInstance();
    var listaDeTarefasSalva = prefs.getStringList(listaDeTarefasKey);
    var resultado = <Tarefa>[];

    if (listaDeTarefasSalva != null) {
      for (var tarefaMap in listaDeTarefasSalva) {
        resultado.add(tarefaFromJson(tarefaMap));
      }
    }

    return resultado;
  }

  Future salvar(List<Tarefa> tarefas) async {
    final prefs = await SharedPreferences.getInstance();
    var listaDeTarefasParaSalvar = <String>[];

    for (var tarefa in tarefas) {
      listaDeTarefasParaSalvar.add(tarefaToJson(tarefa));
    }

    prefs.setStringList(listaDeTarefasKey, listaDeTarefasParaSalvar);
  }
}