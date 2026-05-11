import 'package:flutter/material.dart';

/// Outline-bordered `TextFormField` with a prefix icon and an optional password-visibility toggle.
class LabeledTextField extends StatefulWidget {
  const LabeledTextField({
    required this.controller,
    required this.label,
    required this.icon,
    this.keyboardType,
    this.obscureText = false,
    this.togglable = false,
    this.maxLines = 1,
    this.textCapitalization = TextCapitalization.none,
    this.alignLabelWithHint = false,
    this.validator,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool togglable;
  final int maxLines;
  final TextCapitalization textCapitalization;
  final bool alignLabelWithHint;
  final String? Function(String?)? validator;

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  /// Mutable mirror of [LabeledTextField.obscureText]; flipped by the suffix toggle.
  late bool _obscured = widget.obscureText;

  void _toggleObscured() {
    setState(() => _obscured = !_obscured);
  }

  @override
  Widget build(BuildContext context) {
    final Widget? suffix = widget.togglable
        ? IconButton(
            icon: Icon(_obscured ? Icons.visibility : Icons.visibility_off),
            tooltip: _obscured ? 'Show password' : 'Hide password',
            onPressed: _toggleObscured,
          )
        : null;

    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscured,
      maxLines: _obscured ? 1 : widget.maxLines,
      textCapitalization: widget.textCapitalization,
      decoration: InputDecoration(
        labelText: widget.label,
        prefixIcon: Icon(widget.icon),
        suffixIcon: suffix,
        border: const OutlineInputBorder(),
        alignLabelWithHint: widget.alignLabelWithHint,
      ),
      validator: widget.validator,
    );
  }
}
