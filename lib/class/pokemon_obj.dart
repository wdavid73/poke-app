import 'dart:convert';

import 'package:poke_app/class/typepokemon.dart';

class Pokemon {
  int id;
  String name;
  String description;
  List<Typepokemon> type;
  String skill;
  String image;

  Pokemon({
    required this.id,
    required this.name,
    required this.description,
    this.type = const <Typepokemon>[],
    required this.skill,
    required this.image,
  });

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, description: $description, type: $type, skill: $skill, image: $image)';
  }

  factory Pokemon.fromMap(Map<String, dynamic> data) {
    List<Typepokemon> type = [];
    if (data['type'] != null) {
      final item = data['type'];
      final arr = <Typepokemon>[];
      item.forEach((i) => arr.add(Typepokemon.fromJson(i)));
      type = arr;
    }
    return Pokemon(
      id: data['id'].toInt(),
      name: data['name'].toString(),
      description: data['description'].toString(),
      skill: data['skill'].toString(),
      image: data['image'].toString(),
      type: type,
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pokemon].
}

List<Pokemon> parsePokemon(String data) {
  final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
  return parsed.map<Pokemon>((json) => Pokemon.fromMap(json)).toList();
}
