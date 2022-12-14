import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/pages/pokemon/list_pokemon.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/input_custom.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _search = '';

  // final PokemonRepository _pokemonRepository = PokemonRepository();
  // List<Pokemon> pokemon = <Pokemon>[];

  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    // getPokemon();
    pokemonBloc.add(GetPokemon());
  }

  @override
  void dispose() {
    super.dispose();
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
    pokemonBloc.close();
  }

  closeDrawer() {
    Navigator.pop(context);
  }

  goToAddPokemon() {
    closeDrawer();
    Navigator.pushNamed(context, 'create_pokemon');
  }


  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);

    /*void getPokemon() {
      pokemonBloc.add(GetPokemon());
    }*/

    /*void reduceListPokemon() {
      pokemonBloc.add(ReduceListPokemon());
    }*/

    void findPokemon() {
      pokemonBloc.add(FindPokemon(_search));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Poke App'),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white70,
              ),
              child: Image.asset(
                "assets/images/pokemon_logo.png",
                height: responsive.hp(20),
                width: responsive.wp(20),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_circle_outline),
              title: const Text("Add Pokemon"),
              iconColor: Colors.lightBlueAccent,
              hoverColor: Colors.blueAccent,
              onTap: () => goToAddPokemon(),
            ),
          ],
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  height: responsive.hp(5),
                  width: responsive.width,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InputCustom(
                        responsive: responsive,
                        labelText: "Search",
                        hintText: "Search Pokemon",
                        onChange: (text) => _search = text,
                      ),
                      ElevatedButton(
                        onPressed: () => findPokemon(),
                        child: const Text('Find'),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(12.0),
                child: ListPokemon(),
              ),
              /*SizedBox(
                height: responsive.hp(5),
                child: ElevatedButton(
                  onPressed: () => getPokemon(),
                  child: const Text('get pokemon from api'),
                ),
              ),*/
              SizedBox(
                height: responsive.hp(1),
              ),
              /*SizedBox(
                height: responsive.hp(5),
                child: ElevatedButton(
                  onPressed: () => reduceListPokemon(),
                  child: const Text('reduce list'),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
