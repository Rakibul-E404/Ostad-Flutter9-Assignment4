import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../widgets/custom_textfield.dart';
import 'login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      await Provider.of<AuthService>(context, listen: false).register(
        _emailController.text.trim(),
        _passwordController.text.trim(),
        _firstNameController.text.trim(),
        _lastNameController.text.trim(),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed: ${e.toString()}')),
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
                  'Create Account',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                CustomTextField(
                  controller: _firstNameController,
                  label: 'First Name',
                  validator: (value) => value!.isEmpty ? 'Please enter first name' : null,
                ),
                SizedBox(height: 15),
                CustomTextField(
                  controller: _lastNameController,
                  label: 'Last Name',
                  validator: (value) => value!.isEmpty ? 'Please enter last name' : null,
                ),
                SizedBox(height: 15),
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
                  onPressed: _register,
                  child: Text('Register'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: Text('Login'),
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