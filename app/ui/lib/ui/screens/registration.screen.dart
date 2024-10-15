import 'package:flutter/material.dart';
import 'package:ui/ui/widgets/custom_text_field.widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35),
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _registrationHeader(),
            const SizedBox(height: 16),
            _registrationForm(),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _registrationHeader() => const Column(
        children: [
          SizedBox(height: 60),
          Text(
            'Sign up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Create an account to get started',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      );

  Widget _registrationForm() => Column(
        children: [
          const CustomTextFieldWidget(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email),
          ),
          const SizedBox(height: 16),
          const CustomTextFieldWidget(
            hintText: 'Password',
            prefixIcon: Icon(Icons.password),
            suffixIcon: Icon(Icons.visibility),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          const CustomTextFieldWidget(
            hintText: 'Confirm password',
            prefixIcon: Icon(Icons.password),
            suffixIcon: Icon(Icons.visibility),
            obscureText: true,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              const SnackBar(content: Text('Sign up button pressed'));
            },
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 48),
              shape: const StadiumBorder(),
              backgroundColor: Colors.blue,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
            child: const Text(
              'Sign up',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
        ],
      );
}
