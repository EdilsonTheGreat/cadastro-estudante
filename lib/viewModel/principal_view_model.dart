import 'package:cadastro_aula8/models/estudante.dart';
import 'package:cadastro_aula8/service/estudante_service.dart';

class PrincipalViewModel {
  final EstudanteService service;

  PrincipalViewModel(this.service);

  Estudante? get estudanteLogado {
    return service.estudanteLogado;
  }
}
