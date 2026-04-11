import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:serviko_admin/core/constants/app_colors.dart';
import 'package:serviko_admin/core/constants/app_sizes.dart';
import 'package:serviko_admin/core/theme/text_styles.dart';
import 'package:serviko_admin/core/widgets/custom_checkbox.dart';
import 'package:serviko_admin/core/widgets/custom_text_field.dart';
import 'package:serviko_admin/features/auth/presentation/providers/auth_provider.dart';

// Admin Login Form Widget
class AdminLoginForm extends ConsumerStatefulWidget {
  const AdminLoginForm({super.key, required this.isDesktop});

  final bool isDesktop;

  @override
  ConsumerState<AdminLoginForm> createState() => _AdminLoginFormState();
}

class _AdminLoginFormState extends ConsumerState<AdminLoginForm> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final FocusNode _emailFocusNode;
  late final FocusNode _passwordFocusNode;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Handle Login Button
  void _handleLogin() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      ref
          .read(authProvider.notifier)
          .login(_emailController.text.trim(), _passwordController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Container(
      color: AppColors.background,
      constraints: BoxConstraints(
        minHeight: widget.isDesktop ? MediaQuery.of(context).size.height : 0,
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.isDesktop ? AppSizes.xxl * 1.5 : AppSizes.lg,
            vertical: AppSizes.xxl,
          ),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: widget.isDesktop ? AppSizes.xxl : AppSizes.lg,
                  ),

                  // Form Header
                  Text('Admin Sign In', style: AppTextStyles.h1),
                  const SizedBox(height: AppSizes.xs),
                  Text(
                    'Serviko Operations Dashboard',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(
                    height: widget.isDesktop ? AppSizes.xxl : AppSizes.lg,
                  ),

                  // Email Input
                  CustomTextField(
                    controller: _emailController,
                    focusNode: _emailFocusNode,
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onfieldSubmitted: (p0) => _passwordFocusNode.requestFocus(),
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: AppColors.textHint,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                      ).hasMatch(value)) {
                        return 'Enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.lg),

                  // Password Input
                  CustomTextField(
                    controller: _passwordController,
                    focusNode: _passwordFocusNode,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    isPassword: true,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: AppColors.textHint,
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: AppSizes.md),

                  // Remember Me & Forgot Password Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomCheckbox(label: 'Remember me', onChanged: (val) {}),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Forgot password?'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSizes.xl),

                  // Login Button
                  ElevatedButton(
                    onPressed: authState.isLoading ? null : _handleLogin,
                    child: authState.isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text('Sign In to Dashboard'),
                  ),
                  const SizedBox(height: AppSizes.xl),

                  // Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.security_outlined,
                        size: 16,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: AppSizes.sm),
                      Text(
                        'Protected by Serviko Security',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
