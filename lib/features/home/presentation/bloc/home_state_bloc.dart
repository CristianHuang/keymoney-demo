import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/core/util/date_extensions.dart';
import 'home_state_state.dart';

part 'home_state_event.dart';

class HomeStateBloc extends Bloc<HomeEvent, HomeState> {
  HomeStateBloc() : super(const HomeState()) {
    on<HomeStarted>((event, emit) {
      final currentGreeting = DateTime.now().greeting;
      emit(state.copyWith(greeting: currentGreeting));
    });
  }
}
