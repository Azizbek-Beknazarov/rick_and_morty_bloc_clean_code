import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';

abstract class CharListState extends Equatable {
  const CharListState();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class CharacterEmpty extends CharListState {
  @override
  List<Object> get props => [];
}

class CharacterLoading extends CharListState {
  final List<CharacterEntity> oldList;
  final bool isFirstFetch;

  const CharacterLoading(this.oldList, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldList];
}

class CharacterLoaded extends CharListState {
  final List<CharacterEntity> charList;

  const CharacterLoaded(this.charList);

  @override
  List<Object> get props => [charList];
}

class CharacterError extends CharListState {
  final String message;

  const CharacterError({required this.message});

  @override
  List<Object> get props => [message];
}
