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
  /// Current theme choice. Starts off following the OS, then sticks
  /// to whatever the user picks once they tap the toggle.
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Registration Form',
      debugShowCheckedModeBanner: false,
      /// Tells Flutter which palette to use right now.
      themeMode: _themeMode,
      /// Cheerful daytime palette — M3, blue seed, Roboto.
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        fontFamily: 'Roboto',
        brightness: Brightness.light,
      ),
      /// Cozy nighttime palette — same vibe, just dimmed.
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        fontFamily: 'Roboto',
        brightness: Brightness.dark,
      ),
      /// [Builder] gives us a context below [MaterialApp] so
      /// `MediaQuery` can read the right platform brightness.
      home: Builder(
        builder: (BuildContext context) {
          /// Works out whether we're *actually* dark right now — picks
          /// up the OS setting when the mode is still `system`.
          final Brightness platformBrightness = MediaQuery.platformBrightnessOf(context);
          final bool isDarkMode =
              _themeMode == ThemeMode.dark || (_themeMode == ThemeMode.system && platformBrightness == Brightness.dark);

          return HomeScreen(
            isDarkMode: isDarkMode,
            /// One tap flips to the opposite explicit mode — user's
            /// choice wins from here on.
            onToggleTheme: () => setState(() {
              _themeMode = isDarkMode ? ThemeMode.light : ThemeMode.dark;
            }),
          );
        },
      ),
    );
  }
}
