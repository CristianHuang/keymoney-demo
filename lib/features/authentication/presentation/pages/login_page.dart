import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:keymoneydemo/core/theme/app_colors.dart';
import 'package:keymoneydemo/features/authentication/presentation/pages/register_page.dart';
import 'package:keymoneydemo/features/authentication/presentation/pages/lost_password_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_event.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_state.dart';

import 'package:keymoneydemo/features/home/presentation/pages/main_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido a \n KeyMoney',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              'Gestiona tus ingresos de la mejor manera',
              style: TextStyle(fontSize: 16, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 60),
            SizedBox(
              width: 350,
              height: 65,
              child: TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Correo electrónico',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 350,
              height: 65,
              child: TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  hintText: 'Contraseña',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: 35),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LostPasswordPage(),
                  ),
                );
              },
              child: Text(
                '¿Olvidaste tu contraseña?',
                style: TextStyle(fontSize: 16, color: Color(0xFFD6ADFF)),
              ),
            ),
            SizedBox(height: 20),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                    (route) => false,
                  );
                } else if (state is AuthFailure) {
                  DelightToastBar(
                    autoDismiss: true,
                    position: DelightSnackbarPosition.top,
                    builder: (context) => ToastCard(
                      color: AppColors.background2,
                      leading: Icon(Icons.error_outline, color: AppColors.red),
                      title: Text(
                        "Credenciales incorrectas",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ).show(context);
                }
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthSignInRequested(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(350, 65),
                  ),
                  child: Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RegisterPage()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: '¿No tienes una cuenta? ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'Registrate',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFFD6ADFF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
