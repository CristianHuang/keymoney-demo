import 'package:keymoneydemo/features/authentication/domain/repositories/authentication_repository.dart';

class SignOutUser {
  final AuthenticationRepository repository;

  SignOutUser({required this.repository});

  Future<void> call() async {
    return await repository.signOut();
  }
}
