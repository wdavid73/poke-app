import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/pages/pokemon/list_pokemon.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/input_custom.dart';
import 'package:poke_app/widgets/water_mark.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    init();
  }

  init() {
    _getPokemon();
  }

  Future<void> _getPokemon() async {
    final pokemonBloc = BlocProvider.of<PokemonBloc>(context);
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

  goToListType() {
    closeDrawer();
    Navigator.pushNamed(context, 'list_type_pokemon');
  }

  goToTest() {
    closeDrawer();
    Navigator.pushNamed(context, 'test_page');
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);
    // final pokemonBloc = BlocProvider.of<PokemonBloc>(context);

    // TODO: Implement update Pokemon

    // TODO: Implement List Types Available
    // TODO: Implement Create type Pokemon
    // TODO: Implement delete Type Of Pokemon
    // TODO: Implement update type of pokemon

    // TODO: Change icon of app
    // TODO: home page implement reload list with scroll vertical

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      extendBodyBehindAppBar: true,
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
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text("List type pokemon"),
              iconColor: Colors.lightBlueAccent,
              hoverColor: Colors.blueAccent,
              onTap: () => goToListType(),
            ),
            ListTile(
              leading: const Icon(Icons.terrain_sharp),
              title: const Text("Test"),
              iconColor: Colors.lightBlueAccent,
              hoverColor: Colors.blueAccent,
              onTap: () => goToTest(),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: responsive.width,
              height: responsive.height,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    left: 20,
                    top: responsive.dp(10),
                    child: Text(
                      "Pokedex",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorManager.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.dp(3),
                      ),
                    ),
                  ),
                  Positioned(
                    left: responsive.wp(60),
                    top: -responsive.hp(10),
                    child: const WaterMark(
                      opacity: 0.2,
                      color: Colors.grey,
                      size: 30,
                    ),
                  ),
                  Positioned(
                    top: responsive.dp(15),
                    child: RefreshIndicator(
                      onRefresh: () async {
                        // print("reload");
                      },
                      child: const ListPokemon(),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: responsive.hp(1),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchPokemon extends StatelessWidget {
  const SearchPokemon({
    super.key,
    required this.responsive,
  });

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              onChange: (text) => {},
            ),
            ElevatedButton(
              onPressed: () => {},
              child: const Text('Find'),
            ),
          ],
        ),
      ),
    );
  }
}
