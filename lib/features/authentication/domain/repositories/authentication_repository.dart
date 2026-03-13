import 'package:keymoneydemo/features/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationRepository {
  Future<UserEntity> signInWithEmailAndPassword(String email, String password);
  Future<UserEntity> signUpWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}
