import 'package:flutter/material.dart';
import '../model/pet.dart';
import '../util/dbhelper.dart';
import './addpet.dart';
import './deletepet.dart';


class PetList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PetListState();
}

class PetListState extends State<PetList> {
  DbHelper helper = DbHelper();
  List<Pet>? pets;
  int count = 0;

  // Método pra recuperar os dados
  void getData() {
    var dbFuture = helper.initializeDb();

    dbFuture.then((result) {
      var petsFuture = helper.getPets();

      petsFuture.then((result) {
        List<Pet> petList = <Pet>[];
        count = result.length;

        for (int i = 0; i < count; i++) {
          petList.add(Pet.fromMap(result[i]));
          debugPrint(petList[i].nome);
        }

        setState(() {
          pets = petList;
        });

        debugPrint('Pets: ' + count.toString());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (pets == null) {
      pets = <Pet>[];
      getData();
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Pets'),
      ),
      body: petListItems(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddPet())).then((
              result) {
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
                    builder: (context) => DeletePet(pet: this.pets![position]))).then((
                result) {
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


