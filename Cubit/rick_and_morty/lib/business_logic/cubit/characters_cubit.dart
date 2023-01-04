import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  CharactersCubit() : super(CharactersInitial());
}
