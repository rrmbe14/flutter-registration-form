import 'package:flutter/material.dart';
import 'package:registration_form/screens/home_screen.dart';

void main() {
  runApp(const RegistrationFormApp());
}

class RegistrationFormApp extends StatefulWidget {
  const RegistrationFormApp({super.key});

  @override
  State<RegistrationFormApp> createState() => _RegistrationFormAppState();
}

class _RegistrationFormAppState extends State<RegistrationFormApp> {
  final ValueNotifier<ThemeMode> _themeMode =
      ValueNotifier<ThemeMode>(ThemeMode.system);

  @override
  void dispose() {
    _themeMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: _themeMode,
      builder: (BuildContext context, ThemeMode mode, _) {
        return MaterialApp(
          title: 'Registration Form',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorSchemeSeed: Colors.blue,
            brightness: Brightness.dark,
          ),
          themeMode: mode,
          home: HomeScreen(themeMode: _themeMode),
        );
      },
    );
  }
}
