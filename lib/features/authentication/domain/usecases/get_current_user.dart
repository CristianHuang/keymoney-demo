import 'package:keymoneydemo/features/authentication/domain/entities/user_entity.dart';
import 'package:keymoneydemo/features/authentication/domain/repositories/authentication_repository.dart';

class GetCurrentUser {
  final AuthenticationRepository repository;

  GetCurrentUser({required this.repository});

  Future<UserEntity?> call() async {
    return await repository.getCurrentUser();
  }
}
