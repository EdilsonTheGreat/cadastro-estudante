import 'package:cadastro_aula8/service/estudante_service.dart';
import 'package:cadastro_aula8/views/tela_login.dart';
import 'package:cadastro_aula8/views/tela_principal.dart';
import 'package:cadastro_aula8/views/tela_registo.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final EstudanteService service = EstudanteService();

    return MaterialApp(
      title: 'Estudantes ISUTC',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
      ),
      initialRoute: '/login',
      routes: {
        '/registo': (context) => TelaRegisto(service: service),
        '/login': (context) => TelaLogin(service: service),
        '/principal': (context) => TelaPrincipal(service: service),
      },
    );
  }
}
