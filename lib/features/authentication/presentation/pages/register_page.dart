import 'package:flutter/material.dart';
import 'package:keymoneydemo/features/authentication/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_event.dart';
import 'package:keymoneydemo/features/authentication/presentation/bloc/auth_state.dart';
import 'package:keymoneydemo/features/home/presentation/pages/main_screen.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                controller: _emailController,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 350,
              height: 65,
              child: TextField(
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
                controller: _passwordController,
              ),
            ),
            SizedBox(height: 30),
            BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  // Navigate to home or show success
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainScreen()),
                  );
                } else if (state is AuthFailure) {}
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                      AuthSignUpRequested(
                        email: _emailController.text,
                        password: _passwordController.text,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6B0ACC),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    minimumSize: const Size(350, 65),
                  ),
                  child: Text(
                    'Registrarme',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
              child: Text.rich(
                TextSpan(
                  text: '¿Ya tienes una cuenta? ',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                  children: [
                    TextSpan(
                      text: 'Iniciar sesión',
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
