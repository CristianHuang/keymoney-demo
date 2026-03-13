import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_in_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_out_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/get_current_user.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_event.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_state.dart';
import 'package:keymoneydemo/core/database/database.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInUser signInUser;
  final SignUpUser signUpUser;
  final SignOutUser signOutUser;
  final GetCurrentUser getCurrentUser;
  final AppDatabase database;

  AuthBloc({
    required this.signInUser,
    required this.signUpUser,
    required this.signOutUser,
    required this.getCurrentUser,
    required this.database,
  }) : super(AuthInitial()) {
    // Mapea el evento AuthSignInRequested a la función _onSignInRequested
    on<AuthSignInRequested>(_onSignInRequested);
    on<AuthSignUpRequested>(_onSignUpRequested);
    on<AuthSignOutRequested>(_onSignOutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  Future<void> _onSignInRequested(
    AuthSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Llama al Caso de Uso de Dominio
      final userEntity = await signInUser(event.email, event.password);
      _saveUserEmail(event.email); // No await to prevent blocking login
      emit(AuthSuccess(user: userEntity));
    } catch (e) {
      // Maneja errores y emite un estado de fallo
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignUpRequested(
    AuthSignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // Llama al Caso de Uso de Dominio
      final userEntity = await signUpUser(event.email, event.password);
      _saveUserEmail(event.email); // No await to prevent blocking login
      emit(AuthSuccess(user: userEntity));
    } catch (e) {
      // Maneja errores y emite un estado de fallo
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onSignOutRequested(
    AuthSignOutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await signOutUser();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    final user = await getCurrentUser();
    if (user != null) {
      _saveUserEmail(user.email); // No await
      emit(AuthSuccess(user: user));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> _saveUserEmail(String email) async {
    try {
      final existingProfile = await (database.select(
        database.profiles,
      )..where((t) => t.email.equals(email))).getSingleOrNull();

      if (existingProfile == null) {
        await database
            .into(database.profiles)
            .insert(ProfilesCompanion.insert(email: email));
      }
    } catch (e) {}
  }
}
