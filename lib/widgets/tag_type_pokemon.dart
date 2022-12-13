import 'package:flutter/material.dart';
import 'package:poke_app/class/typepokemon.dart';

class TagTypePokemon extends StatelessWidget {
  final List<Typepokemon> types;
  final double width;

  const TagTypePokemon({super.key, required this.types, required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 100,
        width: width,
        color: Colors.blue,
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 2,
          children: List.generate(
            types.length,
            (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Container(
                  color: Colors.red,
                  child: Center(
                    child: Text(
                      '${types[index].name}',
                    ),
                  ),
                ),
              );
            },
          ),
        )
        /* child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: types.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                width: 50,
                color: Colors.green,
                child: Text(
                  '${types[index].name}',
                ),
              ),
            ],
          );
        },
      ), */
        );
  }
}
