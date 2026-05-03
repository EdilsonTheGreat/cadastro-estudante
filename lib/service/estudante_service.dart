import 'package:cadastro_aula8/models/estudante.dart';

class EstudanteService {
  final List<Estudante> _estudantes = [];
  Estudante? _estudanteLogado;

  Estudante? get estudanteLogado => _estudanteLogado;

  void adicionarEstudante(Estudante estudante) {
    if (verificarContacto(estudante.contacto)) {
      throw Exception("Estudante já existe");
    }
    _estudantes.add(estudante);
  }

  bool login(String contacto, String senha) {
    for (Estudante e in _estudantes) {
      if (e.contacto == contacto.trim() && e.senha == senha.trim()) {
        _estudanteLogado = e;
        return true;
      }
    }
    return false;
  }

  bool verificarContacto(String contacto) {
    for (Estudante e in _estudantes) {
      if (e.contacto == contacto.trim()) {
        return true;
      }
    }
    return false;
  }
}
