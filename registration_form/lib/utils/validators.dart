/// Centralized form-field validators used across the registration flow.
///
/// Each method matches Flutter's `FormFieldValidator<String>` shape:
/// returns `null` when valid, or an error message string when invalid.
class Validators {
  const Validators._();

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final int digitCount = RegExp(r'\d').allMatches(value).length;
    if (digitCount < 10) {
      return 'Phone must be at least 10 digits';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  /// Confirm-password validator. Takes the original password as a second
  /// argument; use via a closure at the call site:
  ///   `validator: (v) => Validators.confirmPassword(v, _passwordController.text)`
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != original) {
      return 'Passwords do not match';
    }
    return null;
  }

  static String? age(String? value) {
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
  }

  static String? country(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your country';
    }
    return null;
  }
}
