import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'APPROVED':
        bgColor = Colors.green.withAlpha(10);
        textColor = Colors.green;
        break;
      case 'BLOCKED':
        bgColor = Colors.red.withAlpha(10);
        textColor = Colors.red;
        break;
      case 'PENDING':
      default:
        bgColor = Colors.orange.withAlpha(10);
        textColor = Colors.orange;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        status,
        softWrap: false,
        overflow: TextOverflow.visible,
        style: TextStyle(
          color: textColor,
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
