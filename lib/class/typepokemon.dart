import 'dart:convert';

class Typepokemon {
  int? id;
  String? name;
  String? description;
  String? color;
  int? state;

  Typepokemon({
    this.id,
    this.name,
    this.description,
    this.color,
    this.state,
  });

  @override
  String toString() {
    return 'Typepokemon(id: $id, name: $name, description: $description, color: $color, state: $state)';
  }

  factory Typepokemon.fromMap(Map<String, dynamic> data) => Typepokemon(
        id: data['id'] as int?,
        name: data['name'] as String?,
        description: data['description'] as String?,
        color: data['color'] as String?,
        state: data['state'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'name': name,
        'description': description,
        'color': color,
        'state': state,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Typepokemon].
  factory Typepokemon.fromJson(Map<String, dynamic> data) {
    return Typepokemon(
      id: data['id'].toInt(),
      name: data['name'].toString(),
      description: data['description'].toString(),
      color: data['color'].toString(),
    );
  }

  /// `dart:convert`
  ///
  /// Converts [Typepokemon] to a JSON string.
  String toJson() => json.encode(toMap());
}
