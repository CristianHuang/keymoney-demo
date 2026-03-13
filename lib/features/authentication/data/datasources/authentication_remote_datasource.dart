import 'package:keymoneydemo/features/authentication/domain/entities/user_entity.dart';

abstract class AuthenticationRemoteDataSource {
  Future<UserEntity> signIn(String email, String password);
  Future<UserEntity> signUp(String email, String password);
  Future<void> signOut();
  Future<UserEntity?> getCurrentUser();
}

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  UserEntity? _currentUser;

  @override
  Future<UserEntity> signIn(String email, String password) async {
    _currentUser = UserEntity(uid: "demo_uid", email: email);
    return _currentUser!;
  }

  @override
  Future<UserEntity> signUp(String email, String password) async {
    _currentUser = UserEntity(uid: "demo_uid", email: email);
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return _currentUser;
  }
}
