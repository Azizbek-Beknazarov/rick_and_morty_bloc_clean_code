import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rick_and_morty_bloc_clean_code/core/platform/network_info.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/datasource/character_local_datasource.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/datasource/character_remote_datasource.dart';
import 'package:rick_and_morty_bloc_clean_code/features/data/repository/character_repo_impl.dart';
import 'package:rick_and_morty_bloc_clean_code/features/domain/repository/character_repository.dart';
import 'package:rick_and_morty_bloc_clean_code/features/presentation/bloc/character_list_bloc/char_list_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/domain/usecases/get_character_usecase.dart';
import 'package:http/http.dart' as http;

final ls = GetIt.instance;

Future<void> init() async {
//Cubit
  ls.registerFactory(
      () => CharListCubit(getCharacterUsecase: ls<GetCharacterUsecase>()));

//Usecase
  ls.registerLazySingleton(() => GetCharacterUsecase(ls()));

//Repository
  ls.registerLazySingleton<CharacterRepo>(() => CharacterRepoImple(
      localDataSource: ls(), remoteDataSource: ls(), info: ls()));

//Datasources
  ls.registerLazySingleton<CharacterRemoteDataSource>(
      () => CharacterRemoteDataSourceImple(client: ls()));
  ls.registerLazySingleton<CharacterLocalDataSource>(
      () => CharacterLocalDataSourceImple(sharedPreferences: ls()));
  
  //core
  ls.registerLazySingleton<NetworkInfo>(() => NetworkInfoImple(ls()));

//external
 final SharedPreferences preferences= await SharedPreferences.getInstance();
ls.registerLazySingleton(() => preferences);
ls.registerLazySingleton(() =>http.Client() );
ls.registerLazySingleton(() => InternetConnectionChecker());
}
