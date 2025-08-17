class PokemonDetailModel {
  int order = 0;
  String name = '';
  String spriteImage = '';

  int height = 0;
  int weight = 0;
  int baseExperience = 0;

  List<String> types = [];
  List<String> abilities = [];
  List<String> moves = [];

  PokemonDetailModel({
    this.order = 0,
    this.name = '',
    this.spriteImage = '',
    this.height = 0,
    this.weight = 0,
  });

  PokemonDetailModel.fromJson(Map json) {
    order = json['order'] ?? 0;
    name = json['name'] ?? '';
    spriteImage = json['sprites']?['other']?['home']?['front_default'] ?? '';
    weight = json['weight'] ?? 0;
    height = json['height'] ?? 0;
    baseExperience = json['base_experience'] ?? 0;

    for (Map origin in json['types'] ?? []) {
      Map type = origin['type'];
      types.add(type['name']);
    }

    for (Map skills in json['abilities'] ?? []) {
      Map type = skills['ability'];
      abilities.add(type['name']);
    }

    for (Map temps in json['moves'] ?? []) {
      Map type = temps['move'];
      moves.add(type['name']);
    }
  }
}
