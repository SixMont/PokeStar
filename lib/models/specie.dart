class Specie {
  int baseHappiness;
  int captureRate;
  ObjPokemon color;
  EvolutionChain evolutionChain;
  ObjPokemon? evolvesFromSpecies; // Make nullable
  List<FlavorTextEntries> flavorTextEntries;
  bool formsSwitchable;
  int genderRate;
  List<Genera> genera;
  ObjPokemon generation;
  ObjPokemon growthRate;
  ObjPokemon? habitat; // Make nullable
  bool hasGenderDifferences;
  int hatchCounter;
  int id;
  bool isBaby;
  String name;
  List<Names> names;
  int order;
  List<PalParkEncounters> palParkEncounters;
  List<PokedexNumbers> pokedexNumbers;
  ObjPokemon shape;
  List<Varieties> varieties;

  Specie({
    required this.baseHappiness,
    required this.captureRate,
    required this.color,
    required this.evolutionChain,
    this.evolvesFromSpecies,
    required this.flavorTextEntries,
    required this.formsSwitchable,
    required this.genderRate,
    required this.genera,
    required this.generation,
    required this.growthRate,
    this.habitat,
    required this.hasGenderDifferences,
    required this.hatchCounter,
    required this.id,
    required this.isBaby,
    required this.name,
    required this.names,
    required this.order,
    required this.palParkEncounters,
    required this.pokedexNumbers,
    required this.shape,
    required this.varieties,
  });

  Specie.fromJson(Map<String, dynamic> json)
      : baseHappiness = json['base_happiness'],
        captureRate = json['capture_rate'],
        color = ObjPokemon.fromJson(json['color']),
        evolutionChain = EvolutionChain.fromJson(json['evolution_chain']),
        evolvesFromSpecies = json['evolves_from_species'] != null
            ? ObjPokemon.fromJson(json['evolves_from_species'])
            : null, // Handle nullable
        flavorTextEntries = (json['flavor_text_entries'] as List)
            .map((item) => FlavorTextEntries.fromJson(item))
            .toList(),
        formsSwitchable = json['forms_switchable'],
        genderRate = json['gender_rate'],
        genera = (json['genera'] as List)
            .map((item) => Genera.fromJson(item))
            .toList(),
        generation = ObjPokemon.fromJson(json['generation']),
        growthRate = ObjPokemon.fromJson(json['growth_rate']),
        habitat = json['habitat'] != null
            ? ObjPokemon.fromJson(json['habitat'])
            : null, // Handle nullable
        hasGenderDifferences = json['has_gender_differences'],
        hatchCounter = json['hatch_counter'],
        id = json['id'],
        isBaby = json['is_baby'],
        name = json['name'],
        names = (json['names'] as List)
            .map((item) => Names.fromJson(item))
            .toList(),
        order = json['order'],
        palParkEncounters = (json['pal_park_encounters'] as List)
            .map((item) => PalParkEncounters.fromJson(item))
            .toList(),
        pokedexNumbers = (json['pokedex_numbers'] as List)
            .map((item) => PokedexNumbers.fromJson(item))
            .toList(),
        shape = ObjPokemon.fromJson(json['shape']),
        varieties = (json['varieties'] as List)
            .map((item) => Varieties.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_happiness'] = baseHappiness;
    data['capture_rate'] = captureRate;
    data['color'] = color.toJson();
    data['evolution_chain'] = evolutionChain.toJson();
    data['evolves_from_species'] = evolvesFromSpecies?.toJson(); // Handle nullable
    data['flavor_text_entries'] =
        flavorTextEntries.map((v) => v.toJson()).toList();
    data['forms_switchable'] = formsSwitchable;
    data['gender_rate'] = genderRate;
    data['genera'] = genera.map((v) => v.toJson()).toList();
    data['generation'] = generation.toJson();
    data['growth_rate'] = growthRate.toJson();
    data['habitat'] = habitat?.toJson(); // Handle nullable
    data['has_gender_differences'] = hasGenderDifferences;
    data['hatch_counter'] = hatchCounter;
    data['id'] = id;
    data['is_baby'] = isBaby;
    data['name'] = name;
    data['names'] = names.map((v) => v.toJson()).toList();
    data['order'] = order;
    data['pal_park_encounters'] =
        palParkEncounters.map((v) => v.toJson()).toList();
    data['pokedex_numbers'] =
        pokedexNumbers.map((v) => v.toJson()).toList();
    data['shape'] = shape.toJson();
    data['varieties'] = varieties.map((v) => v.toJson()).toList();
    return data;
  }
}

class ObjPokemon {
  String name;
  String url;

  ObjPokemon({required this.name, required this.url});

  ObjPokemon.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class EvolutionChain {
  String url;

  EvolutionChain({required this.url});

  EvolutionChain.fromJson(Map<String, dynamic> json)
      : url = json['url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    return data;
  }
}

class FlavorTextEntries {
  String flavorText;
  ObjPokemon language;
  ObjPokemon version;

  FlavorTextEntries({
    required this.flavorText,
    required this.language,
    required this.version,
  });

  FlavorTextEntries.fromJson(Map<String, dynamic> json)
      : flavorText = json['flavor_text'],
        language = ObjPokemon.fromJson(json['language']),
        version = ObjPokemon.fromJson(json['version']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['flavor_text'] = flavorText;
    data['language'] = language.toJson();
    data['version'] = version.toJson();
    return data;
  }
}

class Genera {
  String genus;
  ObjPokemon language;

  Genera({
    required this.genus,
    required this.language,
  });

  Genera.fromJson(Map<String, dynamic> json)
      : genus = json['genus'],
        language = ObjPokemon.fromJson(json['language']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['genus'] = genus;
    data['language'] = language.toJson();
    return data;
  }
}

class Names {
  ObjPokemon language;
  String name;

  Names({
    required this.language,
    required this.name,
  });

  Names.fromJson(Map<String, dynamic> json)
      : language = ObjPokemon.fromJson(json['language']),
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['language'] = language.toJson();
    data['name'] = name;
    return data;
  }
}

class PalParkEncounters {
  ObjPokemon area;
  int baseScore;
  int rate;

  PalParkEncounters({
    required this.area,
    required this.baseScore,
    required this.rate,
  });

  PalParkEncounters.fromJson(Map<String, dynamic> json)
      : area = ObjPokemon.fromJson(json['area']),
        baseScore = json['base_score'],
        rate = json['rate'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['area'] = area.toJson();
    data['base_score'] = baseScore;
    data['rate'] = rate;
    return data;
  }
}

class PokedexNumbers {
  int entryNumber;
  ObjPokemon pokedex;

  PokedexNumbers({
    required this.entryNumber,
    required this.pokedex,
  });

  PokedexNumbers.fromJson(Map<String, dynamic> json)
      : entryNumber = json['entry_number'],
        pokedex = ObjPokemon.fromJson(json['pokedex']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['entry_number'] = entryNumber;
    data['pokedex'] = pokedex.toJson();
    return data;
  }
}

class Varieties {
  bool isDefault;
  ObjPokemon pokemon;

  Varieties({
    required this.isDefault,
    required this.pokemon,
  });

  Varieties.fromJson(Map<String, dynamic> json)
      : isDefault = json['is_default'],
        pokemon = ObjPokemon.fromJson(json['pokemon']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_default'] = isDefault;
    data['pokemon'] = pokemon.toJson();
    return data;
  }
}