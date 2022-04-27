import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_bloc_clean_code/core/error/failure.dart';
import 'package:rick_and_morty_bloc_clean_code/core/usecase/usecase.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/repository/character_repository.dart';

class GetCharacterUsecase
    extends Usecases<List<CharacterEntity>, CharacterPageParams> {
 final CharacterRepo characterRepo;
  GetCharacterUsecase(this.characterRepo);
  @override
  Future<Either<Failure, List<CharacterEntity>>> call(
      CharacterPageParams params)async {
    return await characterRepo.getAllCharacter(params.page);
  }
}

class CharacterPageParams extends Equatable {
  final int page;

  const CharacterPageParams({required this.page});

  @override
  List<Object?> get props => [page];
}
