import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/usecases/search_character_usecase.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/search_bloc/search_state.dart';

import '../../../../app_constants.dart';
import '../../../../core/error/failure.dart';

class CharacterSearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchCharacterUsecase searchCharacterUsecase;

  CharacterSearchBloc({required this.searchCharacterUsecase})
      : super(CharacterSearchEmpty()) {
    on<SearchCharacter>(_onEvent);
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHED_FAILURE_MESSAGE;
      default:
        return 'Unexpected Error';
    }
  }

  FutureOr<void> _onEvent(
      SearchCharacter event, Emitter<SearchState> emit) async {
    emit(CharacterSearchLoading());
    final failOrCharacter = await searchCharacterUsecase(
        CharacterQueryParams(query: event.charquery));
    emit(failOrCharacter.fold(
            (l) => CharacterSearchError(message: _mapFailureToMessage(l)),
            (r) => CharacterSearchLoaded(charList: r)));
  }
}
