import 'package:equatable/equatable.dart';

import '../../../domain/entities/character_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object?> get props => [];
}

class CharacterSearchEmpty extends SearchState {}

class CharacterSearchLoading extends SearchState {}

class CharacterSearchLoaded extends SearchState {
  final List<CharacterEntity> charList;

  const CharacterSearchLoaded({required this.charList});

  @override
  List<Object> get props => [charList];
}

class CharacterSearchError extends SearchState {
  final String message;

  const CharacterSearchError({required this.message});

  @override
  List<Object> get props => [message];
}
