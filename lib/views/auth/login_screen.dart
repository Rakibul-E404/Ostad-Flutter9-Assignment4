import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ostad_flutter9_assignment4/services/auth_service.dart';
import 'package:ostad_flutter9_assignment4/views/auth/registration_screen.dart';
import 'package:ostad_flutter9_assignment4/views/auth/recovery_screens/verify_email.dart';
import 'package:ostad_flutter9_assignment4/widgets/custom_textfield.dart';

import '../home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;


  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthService>(context, listen: false).login(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );

      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => HomeScreen()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed: ${e.toString()}')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 80),
                FlutterLogo(size: 100),
                SizedBox(height: 40),
                Text(
                  'Welcome Back',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _passwordController,
                  label: 'Password',
                  validator: (value) => value!.isEmpty ? 'Please enter password' : null,
                  obscureText: true,
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                  onPressed: _login,
                  child: Text('Login'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => VerifyEmailScreen()),
                    );
                  },
                  child: Text('Forgot Password?'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegistrationScreen()),
                        );
                      },
                      child: Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
