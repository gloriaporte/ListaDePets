import 'package:flutter/material.dart';
import '../model/pet.dart';
import 'package:firebase_database/firebase_database.dart';
import './addpet.dart';
import './deletepet.dart';

class PetList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PetListState();
}

class PetListState extends State<PetList> {
  final DatabaseReference _petsRef = FirebaseDatabase.instance.ref('pets');
  List<Pet>? pets;
  int count = 0;

  void getData() async {
    final DatabaseEvent event = await _petsRef.once();  // Obtém os dados do Firebase
    final data = event.snapshot.value;

    if (data != null && data is Map) {  // Verifica se 'data' é um Map
      Map<String, dynamic> petData = Map<String, dynamic>.from(data);

      List<Pet> petList = [];
      petData.forEach((key, value) {
        petList.add(Pet.fromMap(value, key));  // Convertendo para objeto Pet
      });

      setState(() {
        pets = petList;
        count = pets!.length;
      });
  }
}

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pets'),
      ),
      body: petListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddPet())
          ).then((result) {
            if (result == true) {
              getData();
            }
          });
        },
        tooltip: 'Adicionar Pet',
        child: const Icon(Icons.add),
      ),
    );
  }

  ListView petListItems() {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.lightBlue,
              child: Icon(Icons.pets),
            ),
            title: Text(this.pets![position].nome),
            subtitle: Text(this.pets![position].tipo),
            trailing: IconButton(
              icon: Icon(Icons.visibility),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeletePet(pet: this.pets![position])
                    )
                ).then((result) {
                  if (result == true) {
                    getData();
                  }
                });
              },
            ),
            onTap: () {
              debugPrint('Tapped on ' + this.pets![position].id.toString());
            },
          ),
        );
      },
    );
  }
}
