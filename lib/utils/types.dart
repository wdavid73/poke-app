import 'package:flutter/material.dart';
import 'package:poke_app/ui/color_manager.dart';

class TypePokemonData {
  String name;
  Color color;

  TypePokemonData({
    required this.name,
    required this.color,
  });
}

List<TypePokemonData> typesPokemonData = [
  TypePokemonData(name: "Normal", color: ColorManager.normalColor),
  TypePokemonData(name: "Fire", color: ColorManager.fireColor),
  TypePokemonData(name: "Water", color: ColorManager.waterColor),
  TypePokemonData(name: "Grass", color: ColorManager.grassColor),
  TypePokemonData(name: "Electric", color: ColorManager.electricColor),
  TypePokemonData(name: "Ice", color: ColorManager.iceColor),
  TypePokemonData(name: "Fighting", color: ColorManager.fightingColor),
  TypePokemonData(name: "Poison", color: ColorManager.poisonColor),
  TypePokemonData(name: "Ground", color: ColorManager.groundColor),
  TypePokemonData(name: "Flying", color: ColorManager.flyingColor),
  TypePokemonData(name: "Psychic", color: ColorManager.psychicColor),
  TypePokemonData(name: "Bug", color: ColorManager.bugColor),
  TypePokemonData(name: "Rock", color: ColorManager.rockColor),
  TypePokemonData(name: "Ghost", color: ColorManager.ghostColor),
  TypePokemonData(name: "Dragon", color: ColorManager.dragonColor),
  TypePokemonData(name: "Dark", color: ColorManager.darkColor),
  TypePokemonData(name: "Steel", color: ColorManager.steelColor),
  TypePokemonData(name: "Fairy, ", color: ColorManager.fairyColor),
];
