import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fresh_market_app/widgets/buttons/custom_button.dart';
import 'package:fresh_market_app/widgets/input_fields/build_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../core/app_colors.dart';
import '../../screens/dashboard/bottom_navigation_bar.dart';
import '../../services/locations.dart';
import '../view_model/auth_view-model.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}
class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  bool agreeToTerms = false;
  bool obscurePassword = true;
  bool isLoading = false;
  PhoneNumber? phone;


  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 12),
                Text(
                  "Create your account",
                  style: theme.textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  "Join us for farm-fresh produce delivered to your door.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),

                // NAME
                CustomTextField(
                  controller: nameController,
                  label: "Full Name",
                  hint: "",
                  icon: Icons.person,
                  validator: (v) =>
                  v == null || v.isEmpty ? "Enter your name" : null,
                ),

                CustomTextField(
                  label: "Email",
                  hint: "",
                  icon: Icons.email,
                  controller: emailController,
                  fieldType: FieldType.email,
                ),

                CustomTextField(
                  label: "Phone",
                  hint: "",
                  icon: Icons.phone,
                  isPhone: true,
                  fieldType: FieldType.phone,
                  onPhoneChanged: (number) {
                    phone = number;
                  },
                ),

                CustomTextField(
                  label: "Password",
                  hint: "",
                  icon: Icons.visibility,
                  obscureText: true,
                  controller: passwordController,
                  fieldType: FieldType.password,
                ),



                const SizedBox(height: 12),

                // TERMS
                Row(
                  children: [
                    Checkbox(
                      value: agreeToTerms,
                      activeColor: theme.colorScheme.primary,
                      onChanged: (val) => setState(() => agreeToTerms = val!),
                    ),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: "I agree to the ",
                          style: theme.textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: "Terms of Service",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            const TextSpan(text: " and "),
                            TextSpan(
                              text: "Privacy Policy",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),


                CustomButton(
                  text: isLoading ? "Creating..." : "Create Account",
                  backgroundColor: AppColors.accent,
                  foregroundColor: AppColors.primaryContent,
                  onPressed: isLoading ? null : _registerUser,
                ),

                const SizedBox(height: 35),

                // Social / Footer widgets ...
              ],
            ),
          ),
        ),
      ),
    );
  }


  void _registerUser() async {
    if (!agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("You must agree to the Terms & Privacy")),
      );
      return;
    }

    if (!_formKey.currentState!.validate()) return;

    setState(() => isLoading = true);

    final authViewModel = sl<AuthViewModel>();

    try {
      final success = await authViewModel.register(
        nameController.text.trim(),
        emailController.text.trim(),
        phoneController.text.trim(),
        passwordController.text.trim(),
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text( "Registration successful")),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const BottomNavigation(),
          ),
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(authViewModel.error ?? "Registration failed")),
        );
      }

    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }


}
