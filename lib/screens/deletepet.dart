import 'package:flutter/material.dart';
import '/util/dbhelper.dart';
import '/model/pet.dart';

class DeletePet extends StatefulWidget {
  final Pet pet; // Recebe o pet a ser deletado

  DeletePet({required this.pet});

  @override
  State<StatefulWidget> createState() => DeletePetState();
}

class DeletePetState extends State<DeletePet> {
  DbHelper helper = DbHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informações do Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nome: ${widget.pet.nome}', style: TextStyle(fontSize: 20)),
            Text('Sexo: ${widget.pet.sexo}', style: TextStyle(fontSize: 20)),
            Text('Tipo: ${widget.pet.tipo}', style: TextStyle(fontSize: 20)),
            Text('Idade: ${widget.pet.idade ?? "N/A"}', style: TextStyle(fontSize: 20)),
            Text('Ano adotado: ${widget.pet.anoAdotado}', style: TextStyle(fontSize: 20)),
            Text('Vacinado: ${widget.pet.vacinado ? "Sim" : "Não"}', style: TextStyle(fontSize: 20)),
            Text('Castrado: ${widget.pet.castrado ? "Sim" : "Não"}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue, // Cor do botão de excluir
                minimumSize: Size(double.infinity, 60),
                textStyle: const TextStyle(fontSize: 20),
              ),
              onPressed: () {
                helper.deletePet(widget.pet.id!).then((result) {
                  Navigator.pop(context, true);
                });
              },
              child: const Text('Excluir'),
            ),
          ],
        ),
      ),
    );
  }
}
