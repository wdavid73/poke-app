import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/class/typepokemon.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/image_picker.dart';
import 'package:poke_app/widgets/input_custom.dart';
import 'package:poke_app/widgets/snack_bar_message.dart';

class CreatePokemon extends StatefulWidget {
  const CreatePokemon({Key? key}) : super(key: key);

  @override
  State<CreatePokemon> createState() => _CreatePokemonState();
}

class _CreatePokemonState extends State<CreatePokemon> {
  File? _image;
  bool _imageNull = false, isLoading = false;
  String _name = '', _description = '', _skill = '';
  List<Typepokemon> type = <Typepokemon>[];
  final GlobalKey<FormState> _formKey = GlobalKey();

  handlePickImage(file) {
    setState(() {
      if (file != null) {
        _image = file;
      } else {
        _imageNull = true;
      }
    });
  }

  setLoading() {
    setState(() {
      isLoading = !isLoading;
    });
  }

  createPokemon() async {
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    var isOK = _formKey.currentState!.validate();
    _image ?? snackBarMessage(context, "Please pick a image to pokemon");
    if (isOK && _image != null) {
      dynamic data = PokemonFile(
        description: _description,
        name: _name,
        photo: _image,
        skill: _skill,
        typeId: ['5'],
      );

      pokemonBloc.add(CreatePokemonEvent(data));
      Future.delayed(const Duration(seconds: 5)).then(
        (value) => pokemonBloc.add(
          ResetStateCreatedPokemon(),
        ),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    pokemonBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Create Pokemon",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, state) {
            return SizedBox(
              height: responsive.hp(65),
              width: responsive.width,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ImagePickerCustom(
                      responsive: responsive,
                      image: _image,
                      imageNull: _imageNull,
                      onFileChanged: (file) {
                        handlePickImage(file);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InputCustom(
                        responsive: responsive,
                        labelText: "Name of Pokemon",
                        hintText: "Name",
                        onChange: (text) => _name = text,
                        initialValue: 'Charizard',
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter name of pokemon";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InputCustom(
                        responsive: responsive,
                        labelText: "Description of Pokemon",
                        hintText: "Description",
                        onChange: (text) => _description = text,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: InputCustom(
                        responsive: responsive,
                        labelText: "Skill of Pokemon",
                        hintText: "Skill",
                        initialValue: 'Cuerpo llama',
                        onChange: (text) => _skill = text,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Please enter skill of pokemon";
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ElevatedButton.icon(
                        onPressed: () => state.loading ? null : createPokemon(),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                              side: const BorderSide(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        icon: state.loading
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : const Icon(Icons.add_circle_outline),
                        label: const Text(
                          "Create Pokemon",
                        ),
                      ),
                    ),
                    state.pokemonCreated
                        ? const Text("Pokemon created successfully")
                        : Container(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
