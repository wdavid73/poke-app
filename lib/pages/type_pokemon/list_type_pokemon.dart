import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/bloc/type_pokemon/type_pokemon_bloc.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/shimmer/list_shimmer.dart';
import 'package:poke_app/pages/pokemon/widgets/tag_type_pokemon.dart';
import 'package:shimmer/shimmer.dart';

class ListTypePokemon extends StatefulWidget {
  const ListTypePokemon({Key? key}) : super(key: key);

  @override
  State<ListTypePokemon> createState() => _ListTypePokemonState();
}

class _ListTypePokemonState extends State<ListTypePokemon> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() {
    final typePokemonBloc = BlocProvider.of<TypePokemonBloc>(context);
    typePokemonBloc.add(GetTypePokemon());
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Type of Pokemon"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final typePokemonBloc = BlocProvider.of<TypePokemonBloc>(context);
          typePokemonBloc.add(GetTypePokemonRefresh());
          await typePokemonBloc.stream
              .firstWhere((e) => e is! GetTypePokemonRefresh);
        },
        child: Container(
          color: Colors.white,
          child: BlocBuilder<TypePokemonBloc, TypePokemonState>(
            builder: (context, state) {
              if (state.loading) {
                return SizedBox(
                  width: responsive.width,
                  height: responsive.height,
                  child: Shimmer.fromColors(
                    baseColor: Colors.black26,
                    highlightColor: Colors.black12,
                    child: ListShimmer(
                      responsive: responsive,
                    ),
                  ),
                );
              }

              if (state.isDone) {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TagTypePokemon(
                    width: responsive.width,
                    height: responsive.height,
                    types: const [],
                    aspectRatio: 5,
                    spaceVertical: responsive.hp(2),
                    count: 1,
                  ),
                );
              }

              if (state.hasError) {
                return const Text("has error");
              }

              return const Text("no data");
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
