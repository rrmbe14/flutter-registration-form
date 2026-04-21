import 'package:flutter/material.dart';
import 'package:registration_form/models/user_data.dart';

/// Step 2 of registration — the finishing touches.
///
/// Gets page 1's fields through the constructor, gathers the rest,
/// and on submit pops back with a fully filled [UserData]. A back
/// gesture pops `null` and the flow unwinds gracefully.
class RegistrationPage2 extends StatefulWidget {
  const RegistrationPage2({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    super.key,
  });

  final String name;
  final String email;
  final String phone;
  final String password;

  @override
  State<RegistrationPage2> createState() => _RegistrationPage2State();
}

class _RegistrationPage2State extends State<RegistrationPage2> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String _selectedGender = 'Male';

  @override
  void dispose() {
    _ageController.dispose();
    _countryController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      /// Everything checks out — bundle up page 1 + page 2 into one happy [UserData].
      final UserData userData = UserData(
        name: widget.name,
        email: widget.email,
        phone: widget.phone,
        age: _ageController.text,
        gender: _selectedGender,
        country: _countryController.text,
        bio: _bioController.text.trim(),
      );
      /// Multi-level return: close page 2, then close page 1 with the result.
      /// Home's `await Navigator.push<UserData>` resolves directly with [userData].
      Navigator.pop(context);
      Navigator.pop(context, userData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration — Step 2 of 2')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LinearProgressIndicator(value: 1.0),
              const SizedBox(height: 8),
              const Text(
                'Step 2 of 2',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 24),

              TextFormField(
                controller: _ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  prefixIcon: Icon(Icons.cake),
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  final int? age = int.tryParse(value);
                  if (age == null) {
                    return 'Please enter a valid number';
                  }
                  if (age < 18) {
                    return 'You must be at least 18 years old';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'Gender',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
              RadioGroup<String>(
                groupValue: _selectedGender,
                onChanged: _onGenderChanged,
                child: const Column(
                  children: <Widget>[
                    RadioListTile<String>(title: Text('Male'), value: 'Male'),
                    RadioListTile<String>(title: Text('Female'), value: 'Female'),
                    RadioListTile<String>(title: Text('Other'), value: 'Other'),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _countryController,
                textCapitalization: TextCapitalization.words,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  prefixIcon: Icon(Icons.public),
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your country';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              TextFormField(
                controller: _bioController,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Bio (optional)',
                  prefixIcon: Icon(Icons.edit_note),
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),

              ElevatedButton.icon(
                onPressed: _submitForm,
                icon: const Icon(Icons.check_circle),
                label: const Text('Submit'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onGenderChanged(String? value) {
    if (value != null) {
      setState(() => _selectedGender = value);
    }
  }
}
