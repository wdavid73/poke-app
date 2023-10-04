import 'package:flutter/material.dart';
import 'package:poke_app/ui/color_manager.dart';
import 'package:poke_app/utils/responsive.dart';
import 'package:poke_app/widgets/input_custom.dart';

class SearchPokemon extends StatelessWidget {
  const SearchPokemon({
    super.key,
    required this.responsive,
  });

  final Responsive responsive;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      child: InputCustom(
        responsive: responsive,
        inputWidth: responsive.width,
        labelText: "Search Pokemon",
        hintText: "Pokemon, Move, Ability, etc",
        fillColor: ColorManager.backgroundColor,
        borderStyle: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        onChange: (text) => {},
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.black,
        ),
      ),
    );
  }
}
