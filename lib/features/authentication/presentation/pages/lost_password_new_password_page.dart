import 'package:flutter/material.dart';
import 'package:keymoneydemo/features/authentication/presentation/pages/login_page.dart';

class LostPasswordNewPasswordPage extends StatelessWidget {
  const LostPasswordNewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Recuperar cuenta',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
                  hintText: 'Contraseña nueva',
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 25,
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginPage()),
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
                'Continuar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
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
