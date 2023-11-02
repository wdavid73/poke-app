import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/navigation_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/input_custom.dart';

class SearchPokemon extends StatefulWidget {
  const SearchPokemon({
    super.key,
    required this.responsive,
  });

  final Responsive responsive;

  @override
  State<SearchPokemon> createState() => _SearchPokemonState();
}

class _SearchPokemonState extends State<SearchPokemon> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String pokemonName = '';

  void _searchPokemon(name) async {
    var isOk = _formKey.currentState!.validate();
    if (isOk && name != '' && name != null) {
      final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
      pokemonBloc.add(SearchPokemonEvent(name: name));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Debe ingresar el nombre del pokemon"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PokemonBloc, PokemonState>(
      listener: (context, state) {
        if (state.findPokemon == true) {
          _formKey.currentState!.reset();
          Future.delayed(const Duration(milliseconds: 500)).then((value) {
            NavigationManager.go(
              context,
              "details_pokemon",
            );
          });
        }
      },
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InputCustom(
                  responsive: widget.responsive,
                  inputWidth: widget.responsive.width,
                  labelText: "Search Pokemon",
                  hintText: "Pokemon, Move, Ability, etc",
                  fillColor: ColorManager.backgroundColor,
                  borderStyle: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  isLoading: state.loadingSearch,
                  onFieldSubmitted: (text) => _searchPokemon(text),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return "Por favor ingrese el nombre de un pokemon";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 5),
                state.hasError && state.loadingSearch == false
                    ? Text(
                        state.errorMessage,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
