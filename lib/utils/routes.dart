import 'package:flutter/material.dart';
import 'package:poke_app/pages/pokemon/create_pokemon.dart';
import 'package:poke_app/pages/pokemon/home.dart';
import 'package:poke_app/pages/splash_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  "splash_screen": (context) => const SplashScreen(),
  "home": (context) => const MyHomePage(),
  "create_pokemon" : (context) => const CreatePokemon(),
};
