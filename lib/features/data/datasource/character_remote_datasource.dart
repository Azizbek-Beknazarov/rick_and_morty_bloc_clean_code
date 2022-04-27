import 'dart:convert';

import 'package:rick_and_morty_bloc_clean_code/core/error/exception.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/model/character_model.dart';
import 'package:http/http.dart' as http;

abstract class CharacterRemoteDataSource {
  Future<List<CharacterModel>> getAllCharacters(int page);
}

class CharacterRemoteDataSourceImple implements CharacterRemoteDataSource {
  final http.Client client;

  CharacterRemoteDataSourceImple({required this.client});

  @override
  Future<List<CharacterModel>> getAllCharacters(int page) async {
    String url = 'https://rickandmortyapi.com/api/character/?page=$page';
    print('CharacterRemoteDataSourceImple dagi url: $url');

    final response = await client
        .get(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode == 200) {
      final list = jsonDecode(response.body);
      return (list['results'] as List)
          .map((e) => CharacterModel.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}
