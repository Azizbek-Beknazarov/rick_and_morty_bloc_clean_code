import 'package:dartz/dartz.dart';
import 'package:rick_and_morty_bloc_clean_code/core/error/failure.dart';

abstract class Usecases<Type, Params>{
 Future<Either<Failure, Type>> call(Params params);
}