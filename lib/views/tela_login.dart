import 'package:cadastro_aula8/viewModel/login_view_model.dart';
import 'package:cadastro_aula8/service/estudante_service.dart';
import 'package:flutter/material.dart';

class TelaLogin extends StatefulWidget {
  final EstudanteService service;
  const TelaLogin({super.key, required this.service});

  @override
  State<TelaLogin> createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  late final LoginViewModel _vm;
  final _contactoController = TextEditingController();
  final _senhaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _vm = LoginViewModel(widget.service);
    _vm.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _vm.dispose();
    _contactoController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  void _login() {
    try {
      _vm.contacto = _contactoController.text;
      _vm.senha = _senhaController.text;
      _vm.login();
      Navigator.pushNamed(context, '/principal');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _contactoController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Contacto",
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: true,
              controller: _senhaController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Senha",
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Login"),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/registo'),
              child: const Text('Não tens conta? Regista-te'),
            ),
          ],
        ),
      ),
    );
  }
}
