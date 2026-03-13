import 'package:get_it/get_it.dart';
import 'package:keymoneydemo/features/authentication/data/datasources/authentication_remote_datasource.dart';
import 'package:keymoneydemo/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:keymoneydemo/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_in_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_out_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/get_current_user.dart';
import 'package:keymoneydemo/core/config/currency_config.dart';
import 'package:keymoneydemo/core/database/database.dart';

final getIt = GetIt.instance;

void setupInjection() {
  CurrencyConfig.init();

  final database = AppDatabase();
  getIt.registerSingleton<AppDatabase>(database);

  getIt.registerLazySingleton(() => SignInUser(repository: getIt()));
  getIt.registerLazySingleton(() => SignUpUser(repository: getIt()));
  getIt.registerLazySingleton<SignOutUser>(
    () => SignOutUser(repository: getIt()),
  );
  getIt.registerLazySingleton(() => GetCurrentUser(repository: getIt()));

  getIt.registerLazySingleton<AuthenticationRepository>(
    () => AuthenticationRepositoryImpl(remoteDataSource: getIt()),
  );
  getIt.registerLazySingleton<AuthenticationRemoteDataSource>(
    () => AuthenticationRemoteDataSourceImpl(),
  );
}
