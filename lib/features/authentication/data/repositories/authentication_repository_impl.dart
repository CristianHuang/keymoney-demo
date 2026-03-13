import 'package:keymoneydemo/features/authentication/domain/entities/user_entity.dart';
import 'package:keymoneydemo/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:keymoneydemo/features/authentication/data/datasources/authentication_remote_datasource.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource remoteDataSource;

  AuthenticationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await remoteDataSource.signIn(email, password);
  }

  @override
  Future<UserEntity> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    return await remoteDataSource.signUp(email, password);
  }

  @override
  Future<void> signOut() async {
    return await remoteDataSource.signOut();
  }

  @override
  Future<UserEntity?> getCurrentUser() async {
    return await remoteDataSource.getCurrentUser();
  }
}
