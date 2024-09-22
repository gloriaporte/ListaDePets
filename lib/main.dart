import 'package:flutter/material.dart';
import '/util/dbhelper.dart';
import '/model/pet.dart';
import '/screens/petlist.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PetList(),
    );
  }
}



