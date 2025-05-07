// lib/views/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:pdm2_av1_figuras_geometricas/controllers/login_controller.dart';
import 'package:pdm2_av1_figuras_geometricas/utils/app_constants.dart';

class LoginScreen extends StatefulWidget {
  // Não precisa de const porque LoginController não é const
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginController _loginController = LoginController(); // Instancia o controller
  bool _isLoading = false;

  void _performLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      bool success = await _loginController.validateLogin(
        _usernameController.text,
        _passwordController.text,
      );
      setState(() => _isLoading = false);

      if (success && mounted) {
        Navigator.of(context).pushReplacementNamed('/main_menu');
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuário ou senha inválidos!")),
        );
      }
    }
  }

  void _navigateToSplash() {
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/'); // Navega para a SplashScreen
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.acessSystemTitle),
        centerTitle: true,
        leading: IconButton(
           icon: Icon(Icons.arrow_back),
           onPressed: _navigateToSplash,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  AppStrings.loginTitle,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.usernameHint,
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira seu usuário';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: AppStrings.passwordHint,
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, insira sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: _performLogin,
                        child: const Text(AppStrings.loginButton),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}