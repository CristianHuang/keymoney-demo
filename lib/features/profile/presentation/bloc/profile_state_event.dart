part of 'profile_state_bloc.dart';

abstract class ProfileStateEvent {}

class ProfileStateStarted extends ProfileStateEvent {
  ProfileStateStarted();
}
