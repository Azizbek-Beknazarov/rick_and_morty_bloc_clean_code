import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/entities/character_entity.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/page/character_detail_page.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/widgets/character_cache_image_widget.dart';

class SearchResult extends StatelessWidget {
  final CharacterEntity result;

  const SearchResult({Key? key, required this.result}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CharacterDetailPage(
                  characterEntity: result,
                )));
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: CharacterCacheImage(
                imageUrl: result.image,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                result.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                result.location.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
