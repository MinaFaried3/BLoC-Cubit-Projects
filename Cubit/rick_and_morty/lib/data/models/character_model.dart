import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final Origin origin;
  final Location location;
  final String image;
  final String url;
  final String created;

  const Character(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.origin,
      required this.location,
      required this.image,
      required this.url,
      required this.created});

  factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        status: json['status'],
        species: json['species'],
        type: json['type'],
        gender: json['gender'],
        origin: Origin.fromJson(json['origin']),
        location: Location.fromJson(json['location']),
        image: json['image'],
        url: json['url'],
        created: json['created'],
      );

  @override
  List<Object> get props => [
        id,
        name,
        status,
        species,
        type,
        gender,
        origin,
        location,
        image,
        url,
        created,
      ];
}

class Origin extends Equatable {
  final String name;
  final String url;

  const Origin({required this.name, required this.url});

  factory Origin.fromJson(Map<String, dynamic> json) =>
      Origin(name: json['name'], url: json['url']);

  @override
  List<Object> get props => [name, url];
}

class Location extends Equatable {
  final String name;
  final String url;

  const Location({required this.name, required this.url});

  factory Location.fromJson(Map<String, dynamic> json) =>
      Location(name: json['name'], url: json['url']);

  @override
  List<Object> get props => [name, url];
}
