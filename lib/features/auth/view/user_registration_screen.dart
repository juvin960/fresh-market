import 'package:flutter/material.dart';
import 'package:fresh_market_app/widgets/buttons/custom_button.dart';
import 'package:fresh_market_app/widgets/input_fields/build_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../widgets/buttons/social_button.dart';
import '../../../widgets/dividers/labelled_divider.dart';
import '../../core/app_colors.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  bool agreeToTerms = false;
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () {},
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                "Create your account",
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
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
              CustomTextField(
                label: "Full Name",
                hint: "name",
                icon: Icons.person,
              ),
              CustomTextField(
                label: "Email Address",
                hint: "name@example.com",
                icon: Icons.mail,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomTextField(
                label: "Phone Number",
                hint: "254 000-0000",
                icon: Icons.phone_iphone,
                keyboardType: TextInputType.phone,
                prefix: const Text(" "),
              ),

              // Password
              CustomTextField(
                label: "Password",
                hint: "......",
                icon: obscurePassword ? Icons.visibility_off : Icons.visibility,
                obscureText: obscurePassword,
                onIconTap: () {
                  setState(() => obscurePassword = !obscurePassword);
                },
              ),
              const SizedBox(height: 12),

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

              // Primary Button
              CustomButton(
                text: 'Create Account',
                backgroundColor: AppColors.accent,
                foregroundColor: AppColors.primaryContent,
                onPressed: () {

                },
              ),
              const SizedBox(height: 35),

              // Divider "Or continue with"
              DividerLabel(
                label: 'Or Sign up with',
                backgroundColor: AppColors.surfaceLight,
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: SocialButton(
                      label: 'Google',
                      icon: Image.network(
                        // Public Google "G" mark (as in HTML)
                        'https://lh3.googleusercontent.com/aida-public/AB6AXuB5pjNwhUdJpn2-lBhdcyqyK5EJDVIA_HWJsKeNfwbeoG_749Uoqu025Lwt-sPyK2YYzAVlMyZyF1dqaDOFFulV02wZawDR2l_PX_U2pXjlDX1AMg0fgU5VP9P7Z4X912q9uiTZh63Lhl0jjtpSYau-kH5-1u1MCdjFCCIucEwKI-DwHAlHTHeqoXNzzBaUoMcKx_IiNshZ4rtmnFmNxnOx-dMLNTkaGTEwthRYn1FkvxAy_O8fXbIWSdga1p-PUJbLfmzfM_vLKaE',
                        width: 20,
                        height: 20,
                      ),
                      onTap: () {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SocialButton(
                      label: 'Apple',
                      icon: Icon(
                        Icons.apple,
                        color: Colors.black,
                        size: 22,
                      ),
                      onTap: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Footer
              Center(
                child: TextButton(
                  onPressed: () {},
                  child: const Text.rich(
                    TextSpan(
                      text: "Already have an account? ",
                      children: [
                        TextSpan(
                          text: "Log In",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
