import 'package:flutter/material.dart';
import 'package:registration_form/models/user_data.dart';
import 'package:registration_form/screens/registration_page1.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.isDarkMode,
    required this.onToggleTheme,
    super.key,
  });

  /// True when we're showing the dark palette — drives the toggle icon.
  final bool isDarkMode;

  /// Flips light ↔ dark. Handed down from the root so it owns the state.
  final VoidCallback onToggleTheme;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserData? _userData;

  Future<void> _startRegistration() async {
    /// Kick off the flow and wait for the finished [UserData] to come back.
    /// `Navigator.push` (Flutter framework) returns a `Future<T?>` that completes when the pushed route is popped.
    final UserData? result = await Navigator.push<UserData>(
      context,
      MaterialPageRoute<UserData>(
        builder: (BuildContext context) => const RegistrationPage1(),
      ),
    );

    if (!mounted) {
      return;
    }

    /// Got a [UserData] back? Lovely — save it and show the summary.
    if (result != null) {
      setState(() => _userData = result);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registration Form'),
        actions: <Widget>[
          IconButton(
            tooltip: widget.isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: widget.onToggleTheme,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: _userData == null ? _buildWelcome(context) : _buildSummary(context, _userData!),
        ),
      ),
    );
  }

  Widget _buildWelcome(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Icon(Icons.waving_hand, size: 72),
        const SizedBox(height: 16),
        Text(
          'Welcome!',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        const Text(
          "Let's get you registered in two quick steps.",
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),
        ElevatedButton.icon(
          onPressed: _startRegistration,
          icon: const Icon(Icons.app_registration),
          label: const Text('Register'),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            textStyle: const TextStyle(fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _buildSummary(BuildContext context, UserData data) {
    return SingleChildScrollView(
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Thanks, ${data.name}!',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              const Text(
                "Here's everything we saved:",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 16),
              _InfoRow(icon: Icons.person, label: 'Name', value: data.name),
              _InfoRow(icon: Icons.email, label: 'Email', value: data.email),
              _InfoRow(icon: Icons.phone, label: 'Phone', value: data.phone),
              _InfoRow(icon: Icons.cake, label: 'Age', value: data.age),
              _InfoRow(icon: Icons.wc, label: 'Gender', value: data.gender),
              _InfoRow(icon: Icons.public, label: 'Country', value: data.country),
              if (data.bio.isNotEmpty) _InfoRow(icon: Icons.edit_note, label: 'Bio', value: data.bio),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  onPressed: _startRegistration,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Register Again'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(icon, size: 20),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
