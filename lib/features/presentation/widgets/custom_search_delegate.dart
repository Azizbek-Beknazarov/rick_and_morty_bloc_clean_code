import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/search_bloc/search_event.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/search_bloc/search_state.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/widgets/search_result_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
 final _suggestions=[ 'Rick',
  'Morty',];
  @override
  List<Widget>? buildActions(BuildContext context) {
    return ([
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ]);
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          return close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    BlocProvider.of<CharacterSearchBloc>(context, listen: false)
        .add(SearchCharacter(query));

    return BlocBuilder<CharacterSearchBloc, SearchState>(
        builder: (context, state) {
      if (state is CharacterSearchLoading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is CharacterSearchLoaded) {
        //
        final characterList = state.charList;
        //
        if (characterList.isEmpty) {
          return Center(
            child: Text('No one  character'),
          );
        }

        //
        return ListView.builder(
          itemBuilder: (context, index) {
            CharacterEntity result = characterList[index];
            return SearchResult(result: result);
          },
          itemCount: characterList.isNotEmpty ? characterList.length : 0,
        );
        //
      } else if (state is CharacterSearchError) {
        return Center(
          child: Text(state.message),
        );
      }
      return Center(
        child: Icon(Icons.now_wallpaper),
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
   if(query.isNotEmpty){
return Container();
   }

   return ListView.separated(
     padding: const EdgeInsets.all(10),
     itemBuilder: (context, index) {
       return Text(
         _suggestions[index],
         style: const TextStyle(
           fontSize: 16.0,
           fontWeight: FontWeight.w400,
         ),
       );
     },
     separatorBuilder: (context, index) {
       return const Divider();
     },
     itemCount: _suggestions.length,
   );
  }
}
