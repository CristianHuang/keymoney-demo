import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/profile/presentation/bloc/profile_state_state.dart';

part 'profile_state_event.dart';

class ProfileStateBloc extends Bloc<ProfileStateEvent, ProfileState> {
  ProfileStateBloc() : super(ProfileState()) {
    on<ProfileStateEvent>((event, emit) {
      // TODO: Handle this method.
    });
  }
}
