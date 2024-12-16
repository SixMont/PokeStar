class PokeAPI {
  List<Pokemon> pokemon;

  PokeAPI({required this.pokemon});

  PokeAPI.fromJson(Map<String, dynamic> json) : pokemon = [] {
    if (json['pokemon'] != null) {
      json['pokemon'].forEach((v) {
        pokemon.add(Pokemon.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['pokemon'] = pokemon.map((v) => v.toJson()).toList();
    return data;
  }
}

class Pokemon {
  int id;
  String num;
  String name;
  String img;
  List<String> type;
  String height;
  String weight;
  String candy;
  String egg;
  List<NextEvolution> nextEvolution;
  List<PrevEvolution> prevEvolution;

  Pokemon(
      {required this.id,
        required this.num,
        required this.name,
        required this.img,
        required this.type,
        required this.height,
        required this.weight,
        required this.candy,
        required this.egg,
        required this.nextEvolution,
        required this.prevEvolution});

  Pokemon.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        num = json['num'],
        name = json['name'],
        img = json['img'],
        type = List<String>.from(json['type']),
        height = json['height'],
        weight = json['weight'],
        candy = json['candy'],
        egg = json['egg'],
        nextEvolution = json['next_evolution'] != null
            ? List<NextEvolution>.from(
            json['next_evolution'].map((v) => NextEvolution.fromJson(v)))
            : [],
        prevEvolution = json['prev_evolution'] != null
            ? List<PrevEvolution>.from(
            json['prev_evolution'].map((v) => PrevEvolution.fromJson(v)))
            : [];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['num'] = num;
    data['name'] = name;
    data['img'] = img;
    data['type'] = type;
    data['height'] = height;
    data['weight'] = weight;
    data['candy'] = candy;
    data['egg'] = egg;
    data['next_evolution'] =
        nextEvolution.map((v) => v.toJson()).toList();
    data['prev_evolution'] =
        prevEvolution.map((v) => v.toJson()).toList();
    return data;
  }
}

class NextEvolution {
  String num;
  String name;

  NextEvolution({required this.num, required this.name});

  NextEvolution.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}

class PrevEvolution {
  String num;
  String name;

  PrevEvolution({required this.num, required this.name});

  PrevEvolution.fromJson(Map<String, dynamic> json)
      : num = json['num'],
        name = json['name'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['num'] = num;
    data['name'] = name;
    return data;
  }
}