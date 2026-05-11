import 'package:flutter/material.dart';
import 'package:registration_form/screens/registration_page2.dart';
import 'package:registration_form/utils/validators.dart';
import 'package:registration_form/widgets/labeled_text_field.dart';

/// Step 1 of registration — the essentials.
///
/// Pushed by the home screen, pushes on to [RegistrationPage2]. Page 2
/// closes both pages itself with a double-pop so the finished data
/// goes straight home.
class RegistrationPage1 extends StatefulWidget {
  const RegistrationPage1({super.key});

  @override
  State<RegistrationPage1> createState() => _RegistrationPage1State();
}

class _RegistrationPage1State extends State<RegistrationPage1> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _goToNextPage() async {
    if (_formKey.currentState!.validate()) {
      /// Hop over to page 2. Page 2 does its own double-pop on submit,
      /// so this push simply returns when both pages are gone — no
      /// result to inspect here.
      await Navigator.push<void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => RegistrationPage2(
            name: _nameController.text.trim(),
            email: _emailController.text.trim(),
            phone: _phoneController.text.trim(),
            password: _passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration - Step 1 of 2')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LinearProgressIndicator(value: 0.5),
              const SizedBox(height: 8),
              Text(
                'Step 1 of 2',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _nameController,
                label: 'Full Name',
                icon: Icons.person,
                textCapitalization: TextCapitalization.words,
                validator: Validators.name,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _emailController,
                label: 'Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
                validator: Validators.email,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _phoneController,
                label: 'Phone Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
                validator: Validators.phone,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _passwordController,
                label: 'Password',
                icon: Icons.lock,
                obscureText: true,
                togglable: true,
                validator: Validators.password,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _confirmController,
                label: 'Confirm Password',
                icon: Icons.lock_outline,
                obscureText: true,
                togglable: true,
                validator: (String? v) =>
                    Validators.confirmPassword(v, _passwordController.text),
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _goToNextPage,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
