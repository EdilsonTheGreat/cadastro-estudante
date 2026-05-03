import 'package:flutter/material.dart';
import 'package:cadastro_aula8/service/estudante_service.dart';

class LoginViewModel extends ChangeNotifier {
  String contacto = "";
  String senha = "";

  final EstudanteService estudanteService;
  LoginViewModel(this.estudanteService);

  bool login() {
    if (contacto.trim().isEmpty || senha.trim().isEmpty) {
      notifyListeners();
      throw Exception("Preencha todos os campos");
    }
    bool isEstudante = estudanteService.login(contacto, senha);
    if (!isEstudante) {
      notifyListeners();
      limpar();
      throw Exception("Credenciais incorretas");
    }
    limpar();
    notifyListeners();
    return true;
  }

  void limpar() {
    contacto = "";
    senha = "";
  }
}
