import 'package:flutter/material.dart';
import 'package:poke_app/pages/pokemon/create_pokemon.dart';
import 'package:poke_app/pages/pokemon/details_pokemon.dart';
import 'package:poke_app/pages/home.dart';
import 'package:poke_app/pages/splash_screen.dart';
import 'package:poke_app/pages/test.dart';
import 'package:poke_app/pages/type_pokemon/list_type_pokemon.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "splash_screen": (context) => const SplashScreen(),
  "home": (context) => const MyHomePage(),
  "create_pokemon": (context) => const CreatePokemon(),
  "details_pokemon": (context) => const DetailsPokemon(),
  "list_type_pokemon": (context) => const ListTypePokemon(),
  "test_page": (context) => const TestPage(),
};
