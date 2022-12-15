import 'dart:convert';

class TypePokemon {
  int? id;
  String name;
  String? description;
  String color;
  int? state;

  TypePokemon({
    this.id,
    this.name = '',
    this.description,
    this.color = '',
    this.state,
  });

  @override
  String toString() {
    return 'TypePokemon(id: $id, name: $name, description: $description, color: $color, state: $state)';
  }

  factory TypePokemon.fromMap(Map<String, dynamic> data) {
    return TypePokemon(
      id: data['id'].toInt(),
      name: data['name'].toString(),
      description: data['description'].toString(),
      color: data['color'].toString(),
    );
  }
}

List<TypePokemon> parseTypePokemon(String data) {
  final parsed = jsonDecode(data).cast<Map<String, dynamic>>();
  return parsed.map<TypePokemon>((json) => TypePokemon.fromMap(json)).toList();
}
