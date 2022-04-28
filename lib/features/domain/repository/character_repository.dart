import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';

import '../../../core/error/failure.dart';

abstract class CharacterRepo{

   Future<Either<Failure, List<CharacterEntity>>> getAllCharacter(int page);
   Future<Either<Failure, List<CharacterEntity>>> searchCharacter(String query);
}