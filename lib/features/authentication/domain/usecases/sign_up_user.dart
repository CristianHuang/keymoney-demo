import 'package:keymoneydemo/features/authentication/domain/entities/user_entity.dart';
import 'package:keymoneydemo/features/authentication/domain/repositories/authentication_repository.dart';

class SignUpUser {
  final AuthenticationRepository repository;

  SignUpUser({required this.repository});

  Future<UserEntity> call(String email, String password) async {
    // Basic validation
    if (password.length < 8) {
       throw Exception("La contraseña debe tener al menos 8 caracteres.");
    }
    return await repository.signUpWithEmailAndPassword(email, password);
  }
}
