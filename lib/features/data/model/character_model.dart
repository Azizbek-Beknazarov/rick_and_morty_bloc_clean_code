import 'package:rick_and_morty_bloc_clean_code/features/data/model/location_model.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/location_entity.dart';

class CharacterModel extends CharacterEntity {
  CharacterModel(
      {required int id,
      required String name,
      required String status,
      required String gender,
      required LocationEntity? location,
      required String image,
      required List<String> episode,
      required DateTime created})
      : super(
            id: id,
            name: name,
            status: status,
            gender: gender,
            location: location!,
            image: image,
            episode: episode,
      created: created);

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        id: json['id'] as int,
        name: json['name'] as String,
        status: json['status'] as String,
        gender: json['gender'] as String,
        location: json['location'] != null
            ? LocationModel.fromJson(json['location'])
            : null,
        image: json['image'] as String,
        episode:
            (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
        created: DateTime.parse(json['created'] ));
  }

  Map<String, dynamic> toJson() {
    return ({
      'id': id,
      'name': name,
      'status': status,
      'gender': gender,
      'location': location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    });
  }
}
