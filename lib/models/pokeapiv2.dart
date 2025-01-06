class PokeApiV2 {
  List<Abilities> abilities;
  int baseExperience;
  List<GameIndices> gameIndices;
  int height;
  List<dynamic> heldItems; // Utilisation de dynamic pour les éléments null
  int id;
  bool isDefault;
  String locationAreaEncounters;
  List<Moves> moves;
  String name;
  int order;
  Ability species;
  List<Stats> stats;
  List<Types> types;
  int weight;

  PokeApiV2({
    required this.abilities,
    required this.baseExperience,
    required this.gameIndices,
    required this.height,
    required this.heldItems,
    required this.id,
    required this.isDefault,
    required this.locationAreaEncounters,
    required this.moves,
    required this.name,
    required this.order,
    required this.species,
    required this.stats,
    required this.types,
    required this.weight,
  });

  PokeApiV2.fromJson(Map<String, dynamic> json)
      : abilities = (json['abilities'] as List)
      .map((item) => Abilities.fromJson(item))
      .toList(),
        baseExperience = json['base_experience'],
        gameIndices = (json['game_indices'] as List)
            .map((item) => GameIndices.fromJson(item))
            .toList(),
        height = json['height'],
        heldItems = json['held_items'] ?? [],
        id = json['id'],
        isDefault = json['is_default'],
        locationAreaEncounters = json['location_area_encounters'],
        moves = (json['moves'] as List).map((item) => Moves.fromJson(item)).toList(),
        name = json['name'],
        order = json['order'],
        species = Ability.fromJson(json['species']),
        stats = (json['stats'] as List).map((item) => Stats.fromJson(item)).toList(),
        types = (json['types'] as List).map((item) => Types.fromJson(item)).toList(),
        weight = json['weight'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['abilities'] = abilities.map((v) => v.toJson()).toList();
    data['base_experience'] = baseExperience;
    data['game_indices'] = gameIndices.map((v) => v.toJson()).toList();
    data['height'] = height;
    data['id'] = id;
    data['is_default'] = isDefault;
    data['location_area_encounters'] = locationAreaEncounters;
    data['moves'] = moves.map((v) => v.toJson()).toList();
    data['name'] = name;
    data['order'] = order;
    data['species'] = species.toJson();
    data['stats'] = stats.map((v) => v.toJson()).toList();
    data['types'] = types.map((v) => v.toJson()).toList();
    data['weight'] = weight;
    return data;
  }
}

class Abilities {
  Ability ability;
  bool isHidden;
  int slot;

  Abilities({
    required this.ability,
    required this.isHidden,
    required this.slot,
  });

  Abilities.fromJson(Map<String, dynamic> json)
      : ability = Ability.fromJson(json['ability']),
        isHidden = json['is_hidden'],
        slot = json['slot'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ability'] = ability.toJson();
    data['is_hidden'] = isHidden;
    data['slot'] = slot;
    return data;
  }
}

class Ability {
  String name;
  String url;

  Ability({
    required this.name,
    required this.url,
  });

  Ability.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        url = json['url'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['url'] = url;
    return data;
  }
}

class GameIndices {
  int gameIndex;
  Ability version;

  GameIndices({
    required this.gameIndex,
    required this.version,
  });

  GameIndices.fromJson(Map<String, dynamic> json)
      : gameIndex = json['game_index'],
        version = Ability.fromJson(json['version']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['game_index'] = gameIndex;
    data['version'] = version.toJson();
    return data;
  }
}

class Moves {
  Ability move;
  List<VersionGroupDetails> versionGroupDetails;

  Moves({
    required this.move,
    required this.versionGroupDetails,
  });

  Moves.fromJson(Map<String, dynamic> json)
      : move = Ability.fromJson(json['move']),
        versionGroupDetails = (json['version_group_details'] as List)
            .map((item) => VersionGroupDetails.fromJson(item))
            .toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['move'] = move.toJson();
    data['version_group_details'] =
        versionGroupDetails.map((v) => v.toJson()).toList();
    return data;
  }
}

class VersionGroupDetails {
  int levelLearnedAt;
  Ability moveLearnMethod;
  Ability versionGroup;

  VersionGroupDetails({
    required this.levelLearnedAt,
    required this.moveLearnMethod,
    required this.versionGroup,
  });

  VersionGroupDetails.fromJson(Map<String, dynamic> json)
      : levelLearnedAt = json['level_learned_at'],
        moveLearnMethod = Ability.fromJson(json['move_learn_method']),
        versionGroup = Ability.fromJson(json['version_group']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level_learned_at'] = levelLearnedAt;
    data['move_learn_method'] = moveLearnMethod.toJson();
    data['version_group'] = versionGroup.toJson();
    return data;
  }
}

class Sprites {
  String backDefault;
  dynamic backFemale;
  String backShiny;
  dynamic backShinyFemale;
  String frontDefault;
  dynamic frontFemale;
  String frontShiny;
  dynamic frontShinyFemale;

  Sprites({
    required this.backDefault,
    this.backFemale,
    required this.backShiny,
    this.backShinyFemale,
    required this.frontDefault,
    this.frontFemale,
    required this.frontShiny,
    this.frontShinyFemale,
  });

  Sprites.fromJson(Map<String, dynamic> json)
      : backDefault = json['back_default'],
        backFemale = json['back_female'],
        backShiny = json['back_shiny'],
        backShinyFemale = json['back_shiny_female'],
        frontDefault = json['front_default'],
        frontFemale = json['front_female'],
        frontShiny = json['front_shiny'],
        frontShinyFemale = json['front_shiny_female'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['back_default'] = backDefault;
    data['back_female'] = backFemale;
    data['back_shiny'] = backShiny;
    data['back_shiny_female'] = backShinyFemale;
    data['front_default'] = frontDefault;
    data['front_female'] = frontFemale;
    data['front_shiny'] = frontShiny;
    data['front_shiny_female'] = frontShinyFemale;
    return data;
  }
}

class Stats {
  int baseStat;
  int effort;
  Ability stat;

  Stats({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  Stats.fromJson(Map<String, dynamic> json)
      : baseStat = json['base_stat'],
        effort = json['effort'],
        stat = Ability.fromJson(json['stat']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['base_stat'] = baseStat;
    data['effort'] = effort;
    data['stat'] = stat.toJson();
    return data;
  }
}

class Types {
  int slot;
  Ability type;

  Types({
    required this.slot,
    required this.type,
  });

  Types.fromJson(Map<String, dynamic> json)
      : slot = json['slot'],
        type = Ability.fromJson(json['type']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['slot'] = slot;
    data['type'] = type.toJson();
    return data;
  }
}