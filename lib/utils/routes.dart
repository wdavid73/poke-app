import 'package:flutter/material.dart';
import 'package:poke_app/pages/not_found.dart';
import 'package:poke_app/pages/pokemon/create_pokemon.dart';
import 'package:poke_app/pages/pokemon/details_pokemon.dart';
import 'package:poke_app/pages/home.dart';
import 'package:poke_app/pages/pokemon/list_pokemon.dart';
import 'package:poke_app/pages/splash_screen.dart';
import 'package:poke_app/pages/test.dart';
import 'package:poke_app/pages/type_pokemon/list_type_pokemon.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "splash_screen": (context) => const SplashScreen(),
  "home": (context) => const MyHomePage(),
  "list_pokemon": (context) => const ListPokemon(),
  "create_pokemon": (context) => const CreatePokemon(),
  "details_pokemon": (context) => const DetailsContainerPokemon(),
  "list_type_pokemon": (context) => const ListTypePokemon(),
  "test_page": (context) => const TestPage(),
  "not_found": (context) => const NotFound(),
};
