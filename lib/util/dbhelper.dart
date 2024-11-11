import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import '../model/pet.dart';

class DbHelper {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  String refPets = 'pets';
  Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> insertPet(Pet pet) async {
    try {
      DatabaseReference petsRef = _database.ref(refPets);
      await petsRef.push().set(pet.toMap());
    } catch (e) {
      print("Erro ao inserir pet: $e");
    }
  }

  Future<List<Pet>> getPets() async {
    try {
      DatabaseReference petsRef = _database.ref(refPets);
      DataSnapshot snapshot = await petsRef.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> petsMap = snapshot.value as Map<dynamic, dynamic>;

        List<Pet> petList = petsMap.entries.map((entry) {
          return Pet.fromMap(entry.value as Map<String, dynamic>, entry.key);
        }).toList();

        return petList;
      } else {
        return [];
      }
    } catch (e) {
      print("Erro ao buscar pets: $e");
      return [];
    }
  }

  Future<int> getCount() async {
    try {
      DatabaseReference petsRef = _database.ref(refPets);
      DataSnapshot snapshot = await petsRef.get();

      if (snapshot.exists) {
        Map<dynamic, dynamic> petsMap = snapshot.value as Map<dynamic, dynamic>;
        return petsMap.length;
      } else {
        return 0;
      }
    } catch (e) {
      print("Erro ao contar pets: $e");
      return 0;
    }
  }

  Future<void> updatePet(Pet pet) async {
    try {
      DatabaseReference petRef = _database.ref(refPets).child(pet.id.toString());
      await petRef.update(pet.toMap());
    } catch (e) {
      print("Erro ao atualizar pet: $e");
    }
  }

  Future<void> deletePet(String petId) async {
    try {
      DatabaseReference petRef = _database.ref(refPets).child(petId);

      await petRef.remove();
    } catch (e) {
      print("Erro ao deletar pet: $e");
    }
  }
}
