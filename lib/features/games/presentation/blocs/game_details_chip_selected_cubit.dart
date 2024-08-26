import 'package:flutter_bloc/flutter_bloc.dart';

class GameDetailsChipSelectedCubit extends Cubit<int> {
  GameDetailsChipSelectedCubit() : super(0);

  void selectChip(int value) => emit(value);
}
