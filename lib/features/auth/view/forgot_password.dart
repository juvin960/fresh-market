import 'package:flutter/material.dart';
import 'package:fresh_market_app/widgets/buttons/custom_button.dart';
import 'package:fresh_market_app/widgets/input_fields/build_text_field.dart';

import '../../core/app_colors.dart';


class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Column(
                  children: [
                    // Icon Illustration
                    Container(
                      height: 96,
                      width: 96,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.lock_reset,
                          size: 48,
                          color: AppColors.accent),
                    ),
                    const SizedBox(height: 24),

                    // Headline & Body
                    Text(
                      "Forgot Password?",
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Don't worry! It happens. Please enter the email address linked to your fresh produce account.",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    CustomTextField(
                      label: "Email Address",
                      hint: "name@example.com",
                      icon: Icons.mail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 24),

                    CustomButton(
                      text: 'Send Reset Link',
                      backgroundColor: AppColors.accent,
                      foregroundColor: AppColors.primaryContent,
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
            ),

            // Footer
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Text.rich(
                TextSpan(
                  text: "Remember your password? ",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                  ),
                  children: [
                    TextSpan(
                      text: "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.accent,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}