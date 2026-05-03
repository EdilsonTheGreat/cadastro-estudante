import 'package:cadastro_aula8/viewModel/registo_view_model.dart';
import 'package:cadastro_aula8/service/estudante_service.dart';
import 'package:flutter/material.dart';

class TelaRegisto extends StatefulWidget {
  final EstudanteService service;
  const TelaRegisto({super.key, required this.service});

  @override
  State<TelaRegisto> createState() => _TelaRegistoState();
}

class _TelaRegistoState extends State<TelaRegisto> {
  late final RegistoViewModel _vm;

  final _nomeController = TextEditingController();
  final _contactoController = TextEditingController();
  final _senhaController = TextEditingController();
  final _idadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vm = RegistoViewModel(widget.service);

    _vm.addListener(() {
      setState(() {});

      if (_vm.mensagem.contains("sucesso")) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/login',
              (route) => false,
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _contactoController.dispose();
    _senhaController.dispose();
    _idadeController.dispose();
    _vm.dispose();
    super.dispose();
  }

  void _registrar() {
    _vm.nome = _nomeController.text;
    _vm.contacto = _contactoController.text;
    _vm.senha = _senhaController.text;
    _vm.idadeTexto = _idadeController.text;
    _vm.registrar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contactoController,
                decoration: const InputDecoration(
                  labelText: 'Contacto',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _senhaController,
                decoration: const InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Idade',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.cake),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Disciplinas",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              ..._vm.disciplinasDisponiveis.map((disciplina) {
                final selecionada = _vm.disciplinasSelecionadas.contains(disciplina);
                return CheckboxListTile(
                  title: Text(disciplina.nome),
                  value: selecionada,
                  onChanged: (_) {
                    _vm.alternarDisciplina(disciplina);
                  },
                );
              }).toList(),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registrar,
                child: const Text("Registar"),
              ),
              const SizedBox(height: 12),
              if (_vm.mensagem.isNotEmpty)
                Text(
                  _vm.mensagem,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: _vm.mensagem.contains("sucesso")
                        ? Colors.green
                        : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Já tens conta? Faz Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
