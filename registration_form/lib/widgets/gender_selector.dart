import 'package:flutter/material.dart';

/// A controlled radio-group selector for gender.
///
/// The parent owns the selection state — this widget only renders and
/// emits change events via [onChanged].
class GenderSelector extends StatelessWidget {
  const GenderSelector({
    required this.selectedGender,
    required this.onChanged,
    super.key,
  });

  final String selectedGender;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Text(
            'Gender',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        RadioGroup<String>(
          groupValue: selectedGender,
          onChanged: onChanged,
          child: const Column(
            children: <Widget>[
              RadioListTile<String>(title: Text('Male'), value: 'Male'),
              RadioListTile<String>(title: Text('Female'), value: 'Female'),
              RadioListTile<String>(title: Text('Other'), value: 'Other'),
            ],
          ),
        ),
      ],
    );
  }
}
