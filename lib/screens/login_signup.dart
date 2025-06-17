import 'package:flutter/material.dart';
import 'select_table.dart'; // ✅ Corregido: vamos a select_table.dart, no directo al home

class LoginSignUpScreen extends StatefulWidget {
  const LoginSignUpScreen({super.key});

  @override
  State<LoginSignUpScreen> createState() => _LoginSignUpScreenState();
}

class _LoginSignUpScreenState extends State<LoginSignUpScreen> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/fondo_login.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView( // ✅ Corregido: scroll para evitar desbordes
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.95),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Tabs Login / Sign Up
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () => setState(() => isLogin = true),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: isLogin ? Colors.black : Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                color: isLogin ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => isLogin = false),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: !isLogin ? Colors.black : Colors.grey[300],
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                color: !isLogin ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Column(
                        children: [
                          TextField(
                            decoration: const InputDecoration(
                              hintText: 'E-mail',
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextField(
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Password',
                            ),
                          ),
                          const SizedBox(height: 30),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            onPressed: () {
                              // ✅ Ir a selección de mesa después de login
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => SelectTableScreen(isLogin: isLogin),
                                ),
                              );
                            },
                            child: Text(isLogin ? 'Login' : 'Register'),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}