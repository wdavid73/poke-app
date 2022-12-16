import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/dialog_delete_pokemon.dart';
import 'package:poke_app/widgets/image_pokemon.dart';
import 'package:poke_app/widgets/tag_type_pokemon.dart';

class DetailsPokemon extends StatefulWidget {
  const DetailsPokemon({Key? key}) : super(key: key);

  @override
  State<DetailsPokemon> createState() => _DetailsPokemonState();
}

class _DetailsPokemonState extends State<DetailsPokemon> {
  Future<void> showDialogDelete(int? pokemonId) async {
    final navigator = Navigator.of(context);
    final result = await showDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          child: SizedBox(
            width: 300,
            height: 200,
            child: DialogDeletePokemon(
              id: pokemonId,
            ),
          ),
          onWillPop: () => Future.value(false),
        );
      },
    );
    if (result) navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              state.pokemonSelected!.name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              width: responsive.width,
              height: responsive.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ImagePokemon(
                            pokemon: state.pokemonSelected!,
                            responsive: responsive,
                            widthImage: responsive.wp(70),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 25,
                          left: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          state.pokemonSelected!.description.isEmpty
                              ? 'Has no description'
                              : state.pokemonSelected!.description,
                          style: TextStyle(
                            fontSize: responsive.dp(2),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Skill: ${state.pokemonSelected!.skill}",
                          style: TextStyle(
                            fontSize: responsive.dp(1.5),
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 15,
                        ),
                        alignment: Alignment.centerLeft,
                        child: TagTypePokemon(
                          types: state.pokemonSelected!.type,
                          width: responsive.width,
                          height: responsive.hp(10),
                          count: 4,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                      vertical: 5,
                    ),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () => {},
                          icon: const Icon(Icons.mode_edit_outline_outlined),
                          label: const Text("Update"),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.blueAccent,
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () =>
                              showDialogDelete(state.pokemonSelected?.id),
                          icon: const Icon(Icons.delete_forever),
                          label: const Text("Delete"),
                          style: const ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll<Color>(
                              Colors.redAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
