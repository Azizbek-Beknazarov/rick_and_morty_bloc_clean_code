import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required String name, required String url})
      : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        name: json['name'] as String, url: json['url'] as String);
  }

  Map<String, dynamic> toJson() {
    return ({
      'name': name,
      'url': url,
    });
  }
}
