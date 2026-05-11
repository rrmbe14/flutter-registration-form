import 'package:flutter/material.dart';
import 'package:registration_form/models/user_data.dart';
import 'package:registration_form/widgets/info_row.dart';

/// Displays a submitted [UserData] record as a labeled card.
class UserDataCard extends StatelessWidget {
  const UserDataCard({required this.data, super.key});

  final UserData data;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Submitted Information',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            InfoRow(label: 'Name', value: data.name),
            InfoRow(label: 'Email', value: data.email),
            InfoRow(label: 'Phone', value: data.phone),
            InfoRow(label: 'Age', value: data.age.toString()),
            InfoRow(label: 'Gender', value: data.gender),
            InfoRow(label: 'Country', value: data.country),
            if (data.bio.isNotEmpty) InfoRow(label: 'Bio', value: data.bio),
          ],
        ),
      ),
    );
  }
}
