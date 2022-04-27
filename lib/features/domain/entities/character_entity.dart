import 'package:equatable/equatable.dart';

import 'location_entity.dart';

class CharacterEntity extends Equatable{

  final int id;
  final String name;
  final String status;
  final String gender;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final DateTime createdAt;

  const CharacterEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.gender,
    required this.location,
    required this.image,
    required this.episode,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    gender,
    location,
    image,
    episode,
    createdAt,
  ];
}