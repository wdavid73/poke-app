import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/dependecies.dart';
import 'package:poke_app/pages/home.dart';
import 'package:poke_app/ui/locale_manager.dart';
import 'package:poke_app/utils/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: buildRepositories(),
      child: MultiBlocProvider(
        providers: buildBlocs(),
        child: MaterialApp(
          title: 'Poke APP',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const MyHomePage(),
          initialRoute: 'splash_screen',
          routes: routes,
          localizationsDelegates: LocaleManager.localizationsDelegates,
          supportedLocales: LocaleManager.supportedLocales,
        ),
      ),
    );
  }
}
