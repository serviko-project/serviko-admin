import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/action_cell.dart';
import 'package:serviko_admin/features/dashboard/presentation/widgets/provider_cell.dart';
import 'package:serviko_admin/features/providers/domain/entities/provider_status.dart';
import 'package:serviko_admin/features/providers/presentation/widgets/status_badge.dart';

// Table Row Widget for Recent Applications Table
TableRow buildTableRow({
  required BuildContext context,
  required String id,
  required String name,
  required String email,
  required String initials,
  String? profileImageUrl,
  required String title,
  required ProviderStatus status,
}) {
  return TableRow(
    decoration: const BoxDecoration(
      border: Border(bottom: BorderSide(color: Color(0xFFF3F4F6), width: 0.5)),
    ),
    children: [
      // Provider Cell
      Padding(
        padding: const EdgeInsets.only(left: 24.0, top: 12.0, bottom: 12.0),
        child: ProviderCell(
          name: name,
          email: email,
          initials: initials,
          profileImageUrl: profileImageUrl,
        ),
      ),

      // Title
      Center(child: Text(title, style: const TextStyle(fontSize: 12))),

      // Status Badge
      Center(child: StatusBadge(status: status)),

      // Action Cell
      Center(
        child: ActionCell(
          text: 'VIEW',
          onPressed: () {
            context.go('/providers/$id');
          },
        ),
      ),
    ],
  );
}
