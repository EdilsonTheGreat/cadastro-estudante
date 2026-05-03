class Disciplina {
  int _codigo;
  String _nome;
  String _carga;
  String _credito;

  Disciplina(this._codigo, this._nome, this._carga, this._credito);

  String get credito => _credito;

  set credito(String value) {
    _credito = value;
  }

  String get carga => _carga;

  set carga(String value) {
    _carga = value;
  }

  String get nome => _nome;

  set nome(String value) {
    _nome = value;
  }

  int get codigo => _codigo;

  set codigo(int value) {
    _codigo = value;
  }
}
