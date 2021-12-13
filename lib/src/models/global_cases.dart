import 'dart:convert';

import 'dart:core';

GlobalCases globalCasesFromJson(String str) =>
    GlobalCases.fromJson(jsonDecode(str) as Map<String, dynamic>);

String globalCasesToJson(GlobalCases data) => jsonEncode(data.toJson());

class GlobalCases {
  GlobalCases({
    this.all,
  });

  factory GlobalCases.fromJson(Map<String, dynamic> json) => GlobalCases(
        all: Global.fromJson(json['All'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'All': all?.toJson(),
      };

  final Global? all;
}

class Global {
  Global({
    this.population,
    this.confirmed,
    this.recovered,
    this.deaths,
  });

  final int? population;
  final int? confirmed;
  final int? recovered;
  final int? deaths;
  factory Global.fromJson(Map<String, dynamic> json) {
    return Global(
      population: json['population'] as int?,
      confirmed: json['confirmed'] as int?,
      recovered: json['recovered'] as int?,
      deaths: json['deaths'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'population': population,
        'confirmed': confirmed,
        'recovered': recovered,
        'deaths': deaths
      };
}

class User {
  final String name;
  final String email;

  User(this.name, this.email);

  User.fromJson(Map<String, dynamic> json)
      : name = json['name'].toString(),
        email = json['email'].toString();

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
      };
}
