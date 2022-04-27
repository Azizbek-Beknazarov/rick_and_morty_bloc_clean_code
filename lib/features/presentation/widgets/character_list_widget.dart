import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/character_list_bloc/char_list_cubit.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/character_list_bloc/char_list_state.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/widgets/character_card_widget.dart';

class CharacterListWidget extends StatefulWidget {
  const CharacterListWidget({Key? key}) : super(key: key);

  @override
  State<CharacterListWidget> createState() => _CharacterListWidgetState();
}

class _CharacterListWidgetState extends State<CharacterListWidget> {
  final scrollController = ScrollController();
  final int page = -1;

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<CharListCubit>().loadCharacter();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);

    return BlocBuilder<CharListCubit, CharListState>(builder: (context, state) {
      List<CharacterEntity> characters = [];
      bool isLoading = false;

      if (state is CharacterLoading && state.isFirstFetch) {
        return _loadingIndicator();
      } else if (state is CharacterLoading) {
        characters = state.oldList;
        isLoading = true;
      } else if (state is CharacterLoaded) {
        characters = state.charList;
      } else if (state is CharacterError) {
        return Text(
          state.message,
          style: const TextStyle(color: Colors.red, fontSize: 25),
        );
      }
      return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < characters.length) {
              return CharacterCard(characterEntity: characters[index]);
            } else {
              Timer(Duration(milliseconds: 30), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              return _loadingIndicator();
            }
          },
          separatorBuilder: (context, index) {
            return Divider(
              color: Colors.grey[400],
            );
          },
          itemCount: characters.length + (isLoading ? 1 : 0));
    });
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
