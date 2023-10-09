import 'dart:convert';
import 'dart:io';

class Pokemon {
  int? id;
  String name;
  String image;

  Pokemon({
    this.id,
    required this.image,
    required this.name,
  });

  @override
  String toString() {
    return 'Pokemon(id: $id, name: $name image: $image)';
  }

  factory Pokemon.fromMap(Map<String, dynamic> data) {
    return Pokemon(
      id: data['id'] as int,
      name: data['name']["english"] as String,
      image: data['image'] as String,
    );
  }
}

class PokemonFile extends Pokemon {
  File? photo;
  List<String> typeId;

  PokemonFile({
    super.image = '',
    required super.name,
    required this.photo,
    required this.typeId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["image"] = photo;
    data['type_id'] = typeId;
    return data;
  }

  @override
  String toString() {
    return 'PokemonFile(name: $name image: $photo, type: $typeId)';
  }
}

List<Pokemon> parsePokemon(String data) {
  final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
  return parsed.map<Pokemon>((json) => Pokemon.fromMap(json)).toList();
}
