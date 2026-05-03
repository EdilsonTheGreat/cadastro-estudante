import 'package:cadastro_aula8/models/disciplina.dart';

class Estudante {
  String _estId;
  String _nome;
  int _idade;
  String _contacto;
  String _senha;
  List<Disciplina> _disciplinas;

  Estudante(this._estId, this._nome, this._idade, this._contacto, this._senha, this._disciplinas);

  List<Disciplina> get disciplinas => _disciplinas;

  String get senha => _senha;

  String get contacto => _contacto;

  int get idade => _idade;

  String get nome => _nome;

  String get estId => _estId;
}
