import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/character_list_bloc/char_list_state.dart';

import '../../../../app_constants.dart';
import '../../../../core/error/failure.dart';
import '../../../domain/usecases/get_character_usecase.dart';

class CharListCubit extends Cubit<CharListState> {
  final GetCharacterUsecase getCharacterUsecase;

  CharListCubit({required this.getCharacterUsecase}) : super(CharacterEmpty());

  int page = 1;

  void loadCharacter() async {
    if (state is CharacterLoading) return;

    final currentState = state;
    var oldList = <CharacterEntity>[];

    if (currentState is CharacterLoaded) {
      oldList = currentState.charList;
    }
    emit(CharacterLoading(oldList, isFirstFetch: page == 1));

    final failOrCharacter =
        await getCharacterUsecase(CharacterPageParams(page: page));

    failOrCharacter.fold(
            (l) => emit(CharacterError(message: _mapFailureToMessage(l))),
            (r) {
      page++;
      final characters = (state as CharacterLoading).oldList;
      characters.addAll(r);
      print('List uzunligi: ${characters.length.toString()}');
      emit(CharacterLoaded(characters));
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Kutilmagan Xato';
    }
  }
}
