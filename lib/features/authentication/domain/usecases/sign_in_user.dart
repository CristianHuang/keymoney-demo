import 'package:keymoneydemo/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:keymoneydemo/features/authentication/domain/entities/user_entity.dart';

class SignInUser {
  final AuthenticationRepository repository;

  SignInUser({required this.repository});

  Future<UserEntity> call(String email, String password) async {
    // Aquí podrías añadir lógica de validación de email/contraseña si quisieras
    if (password.length < 8) {
       throw Exception("La contraseña debe tener al menos 8 caracteres.");
    }
    return await repository.signInWithEmailAndPassword(email, password);
  }
}
