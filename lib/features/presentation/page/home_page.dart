import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/widgets/character_list_widget.dart';

import '../widgets/custom_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
      title: const Text('Characters'),
      centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
            )
          ],
    ),
      body: CharacterListWidget(),
    );
  }
}
