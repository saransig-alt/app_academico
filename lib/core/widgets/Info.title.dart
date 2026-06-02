import 'package:flutter/material.dart';

class InfoTitle extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoTitle(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
