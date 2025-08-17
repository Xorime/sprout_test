class PokedexDetailModel {
  List<Descriptions>? descriptions;
  int? id;
  bool? isMainSeries;
  String? name;
  List<Names>? names;
  List<PokemonEntries>? pokemonEntries;
  Language? region;

  PokedexDetailModel({
    this.descriptions,
    this.id,
    this.isMainSeries,
    this.name,
    this.names,
    this.pokemonEntries,
    this.region,
  });

  PokedexDetailModel.fromJson(Map json) {
    if (json['descriptions'] != null) {
      descriptions = <Descriptions>[];
      json['descriptions'].forEach((v) {
        descriptions!.add(new Descriptions.fromJson(v));
      });
    }
    id = json['id'];
    isMainSeries = json['is_main_series'];
    name = json['name'];
    if (json['names'] != null) {
      names = <Names>[];
      json['names'].forEach((v) {
        names!.add(new Names.fromJson(v));
      });
    }
    if (json['pokemon_entries'] != null) {
      pokemonEntries = <PokemonEntries>[];
      json['pokemon_entries'].forEach((v) {
        pokemonEntries!.add(new PokemonEntries.fromJson(v));
      });
    }
    region = json['region'] != null ? new Language.fromJson(json['region']) : null;
  }
}

class Descriptions {
  String? description;
  Language? language;

  Descriptions({
    this.description,
    this.language,
  });

  Descriptions.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    language = json['language'] != null ? new Language.fromJson(json['language']) : null;
  }
}

class Language {
  String? name;
  String? url;

  Language({this.name, this.url});

  Language.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }
}

class Names {
  Language? language;
  String? name;

  Names({this.language, this.name});

  Names.fromJson(Map<String, dynamic> json) {
    language = json['language'] != null ? new Language.fromJson(json['language']) : null;
    name = json['name'];
  }
}

class PokemonEntries {
  int? entryNumber;
  Language? pokemonSpecies;

  PokemonEntries({
    this.entryNumber,
    this.pokemonSpecies,
  });

  PokemonEntries.fromJson(Map<String, dynamic> json) {
    entryNumber = json['entry_number'];
    pokemonSpecies = json['pokemon_species'] != null ? new Language.fromJson(json['pokemon_species']) : null;
  }
}
