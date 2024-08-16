import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubits extends Cubit<int> {
  HomeScreenCubits() : super(0);

  void changeIndex(index) {
    emit(index);
  }
}
