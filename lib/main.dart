import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/pokemon/pokemon_bloc.dart';
import 'package:poke_app/bloc/type_pokemon/type_pokemon_bloc.dart';
import 'package:poke_app/pages/home.dart';
import 'package:poke_app/utils/routes.dart';

void main() async {
  await Firebase.initializeApp();
  FirebaseAnalytics.instance;
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<PokemonBloc>(create: (_) => PokemonBloc()),
        BlocProvider<TypePokemonBloc>(create: (_) => TypePokemonBloc()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
      initialRoute: 'splash_screen',
      routes: routes,
    );
  }
}
