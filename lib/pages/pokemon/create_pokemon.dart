import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/bloc/type_pokemon/type_pokemon_bloc.dart';
import 'package:poke_app/class/type_pokemon.dart';
import 'package:poke_app/ui/color_manager.dart';
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
  // String _name = '', _description = '', _skill = '';
  List<TypePokemon> _selectedTypes = <TypePokemon>[];
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<FormFieldState<dynamic>> _selectKey = GlobalKey();

  /*@override
  void dispose() {
    super.dispose();
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    final typePokemonBloc = BlocProvider.of<TypePokemonBloc>(context);
    pokemonBloc.close();
    typePokemonBloc.close();
  }*/

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final typePokemonBloc = BlocProvider.of<TypePokemonBloc>(context);
    typePokemonBloc.add(GetTypePokemon());
  }

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
    // final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    var isOK = _formKey.currentState!.validate();
    _image ?? snackBarMessage(context, "Please pick a image to pokemon");
    if (isOK && _image != null) {
      /* dynamic data = PokemonFile(
        description: _description,
        name: _name,
        photo: _image,
        skill: _skill,
        typeId: _selectedTypes.map((item) => item.id.toString()).toList(),
      ); */
    }
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
        child: SizedBox(
          height: responsive.hp(80),
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
                    onChange: (text) => {},
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
                    onChange: (text) => {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: InputCustom(
                    responsive: responsive,
                    labelText: "Skill of Pokemon",
                    hintText: "Skill",
                    onChange: (text) => {},
                    validator: (text) {
                      if (text!.isEmpty) {
                        return "Please enter skill of pokemon";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: MultiSelect(
                    keyInput: _selectKey,
                    onConfirmSelect: (values) {
                      _selectedTypes = values;
                    },
                    width: responsive.wp(80),
                    onTap: (values) {
                      setState(() {
                        _selectedTypes.remove(values);
                      });
                    },
                  ),
                ),
                BlocBuilder<PokemonBloc, PokemonState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: ElevatedButton.icon(
                            onPressed: () =>
                                state.loading ? null : createPokemon(),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                  side: const BorderSide(
                                    color: Colors.blueAccent,
                                  ),
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
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MultiSelect extends StatelessWidget {
  final double width;
  final GlobalKey<FormFieldState<dynamic>> keyInput;
  final void Function(List<TypePokemon> values) onConfirmSelect;
  final dynamic Function(TypePokemon)? onTap;

  const MultiSelect({
    Key? key,
    required this.onConfirmSelect,
    required this.keyInput,
    this.width = 200,
    this.onTap,
  }) : super(key: key);

  validateMultiSelect(value) {
    if (value.length == 0) {
      return "Please select at least one type for pokemon";
    }

    if (value.length > 2) {
      return "Please select up to two types for the pokemon";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: BlocBuilder<TypePokemonBloc, TypePokemonState>(
        builder: (context, state) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              MultiSelectDialogField(
                key: keyInput,
                items: state.typePokemon
                    .map((type) => MultiSelectItem(type, type.name))
                    .toList(),
                onConfirm: onConfirmSelect,
                validator: (value) {
                  return validateMultiSelect(value);
                },
                listType: MultiSelectListType.CHIP,
                title: const Text(
                  'Types of pokemon',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                buttonText: const Text("Select a type"),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  border: Border.all(color: Colors.black45),
                ),
                chipDisplay: MultiSelectChipDisplay(
                  items: state.typePokemon
                      .map((type) => MultiSelectItem(type, type.name))
                      .toList(),
                  alignment: Alignment.center,
                  onTap: onTap,
                  chipColor: Colors.blueAccent,
                  textStyle: const TextStyle(
                    color: Colors.white,
                  ),
                  colorator: (typePokemon) {
                    Color color = HexColor(typePokemon.color);
                    return color;
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
