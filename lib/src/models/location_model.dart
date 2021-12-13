// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

Welcome welcomeFromJson(String str) =>
    Welcome.fromJson(json.decode(str) as Map<String, dynamic>);

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    this.placeId,
    this.licence,
    this.osmType,
    this.osmId,
    this.lat,
    this.lon,
    this.placeRank,
    this.category,
    this.type,
    this.importance,
    this.addresstype,
    this.name,
    this.displayName,
    this.address,
    this.boundingbox,
  });

  int? placeId;
  String? licence;
  String? osmType;
  int? osmId;
  String? lat;
  String? lon;
  int? placeRank;
  String? category;
  String? type;
  double? importance;
  String? addresstype;
  String? name;
  String? displayName;
  Address? address;
  List<String>? boundingbox;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        placeId: json['place_id'] as int?,
        licence: json['licence'].toString(),
        osmType: json['osm_type'].toString(),
        osmId: json['osm_id'] as int?,
        lat: json['lat'] as String?,
        lon: json['lon'].toString(),
        placeRank: json['place_rank'] as int?,
        category: json['category'].toString(),
        type: json['type'].toString(),
        importance: json['importance'] as double,
        addresstype: json['addresstype'].toString(),
        name: json['name'].toString(),
        displayName: json['display_name'].toString(),
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
        boundingbox: List<String>.from(
            json['boundingbox'].map((x) => x) as List<String>),
      );

  Map<String, dynamic> toJson() => {
        'place_id': placeId,
        'licence': licence,
        'osm_type': osmType,
        'osm_id': osmId,
        'lat': lat,
        'lon': lon,
        'place_rank': placeRank,
        'category': category,
        'type': type,
        'importance': importance,
        'addresstype': addresstype,
        'name': name,
        'display_name': displayName,
        'address': address?.toJson(),
        'boundingbox': List<dynamic>.from(boundingbox!.map((x) => x)),
      };
}

class Address {
  Address({
    this.state,
    this.country,
    this.countryCode,
  });

  String? state;
  String? country;
  String? countryCode;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        state: json['state'].toString(),
        country: json['country'].toString(),
        countryCode: json['country_code'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'state': state,
        'country': country,
        'country_code': countryCode,
      };
}
