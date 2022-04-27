import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/character_list_bloc/char_list_cubit.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/page/home_page.dart';
import 'locator_service.dart' as di;

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
BlocProvider<CharListCubit>(create: (context)=>di.ls<CharListCubit>()..loadCharacter()),
    ], child: MaterialApp(home: HomePage(),));
  }
}


