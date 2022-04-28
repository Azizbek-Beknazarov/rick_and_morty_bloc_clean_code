import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_bloc_clean_code/core/error/failure.dart';
import 'package:rick_and_morty_bloc_clean_code/core/usecase/usecase.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/repository/character_repository.dart';

class SearchCharacterUsecase extends Usecases<List<CharacterEntity>,CharacterQueryParams>{
  final CharacterRepo characterRepo;
  SearchCharacterUsecase(this.characterRepo);
  @override
  Future<Either<Failure, List<CharacterEntity>>> call(CharacterQueryParams params)async {
   return await characterRepo.searchCharacter(params.query);
  }
}

class CharacterQueryParams extends Equatable{
  final String query;
  const CharacterQueryParams({required this.query});
  @override
  // TODO: implement props
  List<Object?> get props => [query];
}