import 'package:flutter/material.dart';
import '/util/dbhelper.dart';
import '/model/pet.dart';
import '/screens/petlist.dart';

class AddPet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AddPetState();
}

class AddPetState extends State<AddPet> {
  DbHelper helper = DbHelper();
  Pet pet = Pet('', '', '', 0, false, false); // Ajuste aqui se necessário
  final _formKey = GlobalKey<FormState>(); // Para validação

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Pet'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form( // Adicione o Form para validação
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Nome'),
                onChanged: (value) {
                  pet.nome = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Sexo'),
                onChanged: (value) {
                  pet.sexo = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Tipo'),
                onChanged: (value) {
                  pet.tipo = value;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Idade'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  pet.idade = int.tryParse(value) ?? 0;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ano em que foi adotado'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  pet.anoAdotado = int.tryParse(value) ?? 0;
                },
              ),
              Row(
                children: <Widget>[
                  const Text('Vacinado'),
                  Checkbox(
                    value: pet.vacinado,
                    onChanged: (value) {
                      setState(() {
                        pet.vacinado = value!;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  const Text('Castrado'),
                  Checkbox(
                    value: pet.castrado,
                    onChanged: (value) {
                      setState(() {
                        pet.castrado = value!;
                      });
                    },
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlue,
                  minimumSize: Size(double.infinity, 60),
                  textStyle: const TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    helper.insertPet(pet).then((result) {
                      Navigator.pop(context, true);
                    });
                  }
                },
                child: const Text('Adicionar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
