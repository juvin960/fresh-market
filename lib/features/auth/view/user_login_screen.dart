import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/auth/view/user_registration_screen.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:fresh_market_app/features/screens/dashboard/bottom_navigation_bar.dart';
import 'package:fresh_market_app/widgets/buttons/social_button.dart';
import 'package:fresh_market_app/widgets/dividers/labelled_divider.dart';
import 'package:fresh_market_app/widgets/input_fields/custom_form.dart';
import 'package:google_fonts/google_fonts.dart';

class UserLoginScreen extends StatefulWidget {
  const UserLoginScreen({super.key});

  @override
  State<UserLoginScreen> createState() => _UserLoginScreenState();
}

class _UserLoginScreenState extends State<UserLoginScreen> {
  final TextEditingController emailCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();
  bool obscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 24.0, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                Container(
                  width: 64,
                  height: 64,
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.20),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.restaurant, // "nutrition" analogue
                    color: AppColors.primary,
                    size: 32,
                  ),
                ),
                Text(
                  'Welcome Back',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textMain,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Log in to track your fresh produce journey.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Email Address',
                  child: TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: inputDecoration(
                      context,
                      hint: 'name@example.com',
                      trailing: Icon(Icons.mail, color: AppColors.textSecondary),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                LabeledField(
                  label: 'Password',
                  footer: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: passwordCtrl,
                    obscureText: obscure,
                    decoration: inputDecoration(
                      context,
                      hint: '••••••••',
                      trailing: IconButton(
                        splashRadius: 20,
                        onPressed: () => setState(() => obscure = !obscure),
                        icon: Icon(
                          obscure ? Icons.visibility_off : Icons.visibility,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
                // Sign In button
                SizedBox(
                  height: 56,
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: AppColors.primaryContent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ).copyWith(
                      overlayColor: WidgetStateProperty.resolveWith(
                            (states) => states.contains(WidgetState.pressed)
                            ? AppColors.primary.withValues(alpha: 0.15)
                            : null,
                      ),
                    ),
                    onPressed: () {
                      _navigateToHomePage();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 8),
                        Text(
                          'Sign In',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                // Divider "Or continue with"
                DividerLabel(
                  label: 'Or continue with',
                  backgroundColor: AppColors.surfaceLight,
                ),
                const SizedBox(height: 20),

                // Social buttons
                Row(
                  children: [
                    Expanded(
                      child: SocialButton(
                        label: 'Google',
                        icon: Image.network(

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

                const SizedBox(height: 20),
                // Footer
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: Center(
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      spacing: 6,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            _navigateToRegistration();
                          },
                          child: Text(
                            'Sign Up',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: AppColors.primaryContent,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _navigateToRegistration() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const UserRegistrationScreen()));

  }

  _navigateToHomePage() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const BottomNavigation()));

  }
}
