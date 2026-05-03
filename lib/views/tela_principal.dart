import 'package:flutter/material.dart';
import 'package:cadastro_aula8/service/estudante_service.dart';
import 'package:cadastro_aula8/viewModel/principal_view_model.dart';

class TelaPrincipal extends StatelessWidget {
  final EstudanteService service;
  TelaPrincipal({super.key, required this.service});

  late final PrincipalViewModel vm = PrincipalViewModel(service);

  @override
  Widget build(BuildContext context) {
    final estudante = vm.estudanteLogado;

    return Scaffold(
      appBar: AppBar(
        title: Text("Olá, ${estudante?.nome ?? 'Utilizador'}"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sair'),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: estudante == null
            ? const Center(child: Text("Nenhum utilizador logado"))
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            child: Icon(Icons.person, size: 30),
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                estudante.nome,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text('Contacto: ${estudante.contacto}'),
                              Text('Idade: ${estudante.idade} anos'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Disciplinas Inscritas',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: estudante.disciplinas.length,
                      itemBuilder: (context, index) {
                        final disciplina = estudante.disciplinas[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: const Icon(
                              Icons.menu_book,
                              color: Colors.indigo,
                            ),
                            title: Text(
                              disciplina.nome,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text("${disciplina.codigo}- ${disciplina.carga} - ${disciplina.credito} creditos"),

                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
