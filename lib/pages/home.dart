import 'package:flutter/material.dart';
import 'package:poke_app/class/pokemon_obj.dart';
import 'package:poke_app/services/repository.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/item_pokemon.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PokemonRepository _pokemonRepository = PokemonRepository();
  List<Pokemon> pokemon = <Pokemon>[];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    _getPokemon();
  }

  Future<dynamic> _getPokemon() async {
    dynamic data = await _pokemonRepository.getPokemon();
    setState(() {
      pokemon = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke App'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: SizedBox(
                  height: responsive.hp(75),
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio:
                        (responsive.width / responsive.height) * 1.5,
                    children: List.generate(
                      pokemon.length,
                      (index) {
                        return ItemPokemon(
                          responsive: responsive,
                          pokemon: pokemon[index],
                        );
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: responsive.hp(5),
                child: ElevatedButton(
                  onPressed: () => _getPokemon(),
                  child: const Text('get pokemon from api'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
