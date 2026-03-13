import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_event.dart';
import 'package:keymoneydemo/features/home/presentation/pages/main_screen.dart';
import 'package:keymoneydemo/core/database/database.dart';
import 'package:keymoneydemo/injection.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_in_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/sign_out_user.dart';
import 'package:keymoneydemo/features/authentication/domain/usecases/get_current_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjection();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(
        signInUser: getIt<SignInUser>(),
        signUpUser: getIt<SignUpUser>(),
        signOutUser: getIt<SignOutUser>(),
        getCurrentUser: getIt<GetCurrentUser>(),
        database: getIt<AppDatabase>(),
      )..add(const AuthCheckRequested()),

      child: MaterialApp(
        title: 'KeyMoney Demo',
        debugShowCheckedModeBanner: true,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: const Color(0xFF101219),
          fontFamily: 'InterLocal',
          textTheme: const TextTheme(
            bodyLarge: TextStyle(fontFamily: 'InterLocal'),
            bodyMedium: TextStyle(fontFamily: 'InterLocal'),
            displayLarge: TextStyle(
              fontFamily: 'InterLocal',
              fontWeight: FontWeight.bold,
            ),
            titleLarge: TextStyle(
              fontFamily: 'InterLocal',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}
