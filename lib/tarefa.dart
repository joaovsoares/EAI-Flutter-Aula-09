import 'dart:convert';

class Tarefa {
  String nome;
  String descricao;
  bool concluida = false;

  Tarefa({this.nome, this.descricao, this.concluida = false});

  Map<String, dynamic> toJson() => {
    "nome": nome,
    "descricao": descricao,
    "concluida": concluida,
  };

  factory Tarefa.fromJson(Map<String, dynamic> json) => Tarefa(
    nome: json["nome"],
    descricao: json["descricao"],
    concluida: json["concluida"],
  );
}

Tarefa tarefaFromJson(String data) => Tarefa.fromJson(json.decode(data));
String tarefaToJson(Tarefa data) => json.encode(data.toJson());