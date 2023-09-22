import 'dart:convert';
import 'dart:io';

class Pokemon {
  int? id;
  String name;
  String? description;
  List<String> type;
  String? skill;
  String image;

  Pokemon({
    this.id,
    required this.image,
    required this.name,
    this.description,
    this.skill,
    this.type = const <String>[],
  });

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name, description: $description, type: $type, skill: $skill, image: $image)';
  }

  factory Pokemon.fromMap(Map<String, dynamic> data) {
    /*List<TypePokemon> type = [];
     if (data['type'] != null) {
      final item = data['type'];
      final arr = <TypePokemon>[];
      item.forEach((i) => arr.add(TypePokemon.fromMap(i)));
      type  = arr;
    }*/
    return Pokemon(
      id: data['id'] as int,
      name: data['name']["english"] as String,
      // description: data['description'].toString(),
      // skill: data['skill'].toString(),
      image: data['image'] as String,
      type: (data["type"] as List).map((item) => item as String).toList(),
    );
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pokemon].
}

class PokemonFile extends Pokemon {
  File? photo;
  List<String> typeId;

  PokemonFile({
    super.image = '',
    required super.name,
    required super.description,
    required super.skill,
    required this.photo,
    required this.typeId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["description"] = description;
    data["skill"] = skill;
    data["image"] = photo;
    data['type_id'] = typeId;
    return data;
  }

  @override
  String toString() {
    return 'PokemonFile(name: $name, description: $description, skill: $skill, image: $photo, type: $typeId)';
  }
}

List<Pokemon> parsePokemon(String data) {
  final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
  return parsed.map<Pokemon>((json) => Pokemon.fromMap(json)).toList();
}
