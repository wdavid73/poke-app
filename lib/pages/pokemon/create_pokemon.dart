import 'package:flutter/material.dart';

class CreatePokemon extends StatelessWidget {
  const CreatePokemon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Pokemon"),
      ),
      body: Container(
        child: Text("Add Pokemon"),
      ),
    );
  }
}
