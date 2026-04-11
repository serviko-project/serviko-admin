import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import '../providers/auth_provider.dart';
import '../widgets/admin_branding_side.dart';
import '../widgets/admin_login_form.dart';

// Admin Login Screen
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDesktop = size.width >= 900;

    ref.listen<AuthState>(authProvider, (previous, state) {
      if (state.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(state.error!),
            backgroundColor: AppColors.error,
          ),
        );
      } else if (state.isAuthenticated) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Login Successful.'),
            backgroundColor: AppColors.success,
          ),
        );
        // TODO: Navigate to Dashboard
      }
    });

    return Scaffold(
      backgroundColor: AppColors.sidebarBackground,
      body: isDesktop
          ? const Row(
              children: [
                Expanded(flex: 5, child: AdminBrandingSide(isDesktop: true)),
                Expanded(flex: 4, child: AdminLoginForm(isDesktop: true)),
              ],
            )
          : const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AdminBrandingSide(isDesktop: false),
                  AdminLoginForm(isDesktop: false),
                ],
              ),
            ),
    );
  }
}
