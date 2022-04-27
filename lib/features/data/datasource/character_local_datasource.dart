import 'dart:convert';

import 'package:rick_and_morty_bloc_clean_code/core/error/exception.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/model/character_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../app_constants.dart';

abstract class CharacterLocalDataSource {
  Future<List<CharacterModel>> getLastCharacterFromCache();

  Future<void> charactersToCache(List<CharacterModel> characters);
}

class CharacterLocalDataSourceImple implements CharacterLocalDataSource {
  final SharedPreferences sharedPreferences;

  CharacterLocalDataSourceImple({required this.sharedPreferences});

  @override
  Future<void> charactersToCache(List<CharacterModel> characters) {
    final List<String> jsonList =
        characters.map((e) => jsonEncode(e.toJson())).toList();
    sharedPreferences.setStringList(CACHED_CHARACTERS_LIST, jsonList);
    print('characters Cache ga yoziladi: ${jsonList.length}');
    return Future.value(jsonList);
  }

  @override
  Future<List<CharacterModel>> getLastCharacterFromCache() {
    final jsonList = sharedPreferences.getStringList(CACHED_CHARACTERS_LIST);
    if (jsonList!.isEmpty) {
      print('Get characters from Cache: ${jsonList.length}');
      return Future.value(
          jsonList.map((e) => CharacterModel.fromJson(jsonDecode(e))).toList());
    } else {
      throw CacheException();
    }
  }
}
