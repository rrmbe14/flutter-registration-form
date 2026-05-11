import 'package:flutter/material.dart';
import 'package:registration_form/models/user_data.dart';
import 'package:registration_form/utils/validators.dart';
import 'package:registration_form/widgets/gender_selector.dart';
import 'package:registration_form/widgets/labeled_text_field.dart';

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
        age: int.parse(_ageController.text),
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

  void _onGenderChanged(String? value) {
    if (value != null) {
      setState(() => _selectedGender = value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registration - Step 2 of 2')),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const LinearProgressIndicator(value: 1.0),
              const SizedBox(height: 8),
              Text(
                'Step 2 of 2',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _ageController,
                label: 'Age',
                icon: Icons.cake,
                keyboardType: TextInputType.number,
                validator: Validators.age,
              ),
              const SizedBox(height: 16),

              GenderSelector(
                selectedGender: _selectedGender,
                onChanged: _onGenderChanged,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _countryController,
                label: 'Country',
                icon: Icons.public,
                textCapitalization: TextCapitalization.words,
                validator: Validators.country,
              ),
              const SizedBox(height: 16),

              LabeledTextField(
                controller: _bioController,
                label: 'Bio (optional)',
                icon: Icons.edit_note,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                alignLabelWithHint: true,
              ),
              const SizedBox(height: 32),

              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
