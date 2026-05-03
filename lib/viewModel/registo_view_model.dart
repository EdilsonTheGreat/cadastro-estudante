import 'package:flutter/material.dart';
import 'dart:math';
import 'package:cadastro_aula8/models/estudante.dart';
import 'package:cadastro_aula8/models/disciplina.dart';
import 'package:cadastro_aula8/service/estudante_service.dart';

class RegistoViewModel extends ChangeNotifier {
  String id = "";
  String nome = "";
  String contacto = "";
  String senha = "";
  String idadeTexto = "";
  String mensagem = "";

  final EstudanteService _service;
  List<Disciplina> disciplinasSelecionadas = [];

  RegistoViewModel(this._service);

  List<Disciplina> disciplinasDisponiveis = [
    Disciplina(100511067, "Programação de Dispositivos Móveis", "4H", "26"),
    Disciplina(100511044, "Segurança Informática e das Comunicações", "4H", "26"),
    Disciplina(100510392, "Processamento Analógico de Sinais", "4H", "26"),
    Disciplina(100510422, "Arquitectura Empresarial", "4H", "26"),
    Disciplina(100511187, "Sistemas de Telecomunicações", "6H", "30"),
    Disciplina(100511213, "Sistemas de Rádio-Comunicações", "4H", "26"),
  ];

  void alternarDisciplina(Disciplina disciplina) {
    if (disciplinasSelecionadas.contains(disciplina)) {
      disciplinasSelecionadas.remove(disciplina);
    } else {
      disciplinasSelecionadas.add(disciplina);
    }
    notifyListeners();
  }

  void registrar() {
    if (nome.trim().isEmpty ||
        contacto.trim().isEmpty ||
        senha.trim().isEmpty ||
        idadeTexto.trim().isEmpty) {
      mensagem = 'Por favor preenche todos os campos.';
      notifyListeners();
      return;
    }

    final idade = int.tryParse(idadeTexto);

    if (idade == null) {
      mensagem = 'Idade inválida.';
      notifyListeners();
      return;
    }

    if (senha.length < 6) {
      mensagem = 'A senha deve ter pelo menos 6 caracteres.';
      notifyListeners();
      return;
    }

    if (_service.verificarContacto(contacto)) {
      mensagem = 'Contacto já existe.';
      notifyListeners();
      return;
    }

    if (disciplinasSelecionadas.isEmpty) {
      mensagem = 'Seleciona pelo menos uma disciplina.';
      notifyListeners();
      return;
    }

    Estudante estudante = Estudante(
        _gerarId(), nome, idade, contacto, senha, List.from(disciplinasSelecionadas));
    _service.adicionarEstudante(estudante);

    mensagem = "Registo efetuado com sucesso!";
    limpar();
    notifyListeners();
  }

  void limpar() {
    id = "";
    nome = "";
    contacto = "";
    senha = "";
    idadeTexto = "";
    disciplinasSelecionadas.clear();
  }

  String _gerarId() {
    final random = Random();
    final numero = random.nextInt(9000) + 1000;
    return "S$numero";
  }
}
