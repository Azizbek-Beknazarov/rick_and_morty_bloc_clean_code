import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_bloc_clean_code/core/error/exception.dart';

import 'package:rick_and_morty_bloc_clean_code/core/error/failure.dart';
import 'package:rick_and_morty_bloc_clean_code/core/platform/network_info.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/datasource/character_local_datasource.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/datasource/character_remote_datasource.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/model/character_model.dart';

import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';

import '../../domain/repository/character_repository.dart';

class CharacterRepoImple implements CharacterRepo {
  final CharacterLocalDataSource localDataSource;
  final CharacterRemoteDataSource remoteDataSource;
  final NetworkInfo info;

  CharacterRepoImple(
      {required this.localDataSource,
      required this.remoteDataSource,
      required this.info});

  @override
  Future<Either<Failure, List<CharacterEntity>>> getAllCharacter(
      int page) async {
    if (await info.isConnected) {
      try {
        final List<CharacterModel> remoteChar =
            await remoteDataSource.getAllCharacters(page);
        localDataSource.charactersToCache(remoteChar);
        return Right(remoteChar);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localChar = await localDataSource.getLastCharacterFromCache();
        return Right(localChar);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
