import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable{
const SearchEvent();
@override
  // TODO: implement props
  List<Object?> get props => [];
}
class SearchCharacter extends SearchEvent{
final String charquery;
const SearchCharacter(this.charquery);
}