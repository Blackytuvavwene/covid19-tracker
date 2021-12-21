import 'dart:convert';

List<Countries> countriesFromJson(String str) => (json.decode(str) as List)
    .map((i) => Countries.fromJson(i as Map<String, dynamic>))
    .toList();

String countriesToJson(List<Countries> data) => json.encode(
      List<dynamic>.from(
        data.map(
          (x) => x.toJson(),
        ),
      ),
    );

class Countries {
  Countries({
    this.code,
    this.name,
  });

  String? code;
  String? name;

  factory Countries.fromJson(Map<String, dynamic> json) => Countries(
        code: json['code'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
      };
}
