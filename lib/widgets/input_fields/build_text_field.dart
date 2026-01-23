import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../features/core/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? prefix;
  final VoidCallback? onIconTap;
  final TextEditingController? controller;
  final String? errorText;
  final Color? fillColor;

  const CustomTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefix,
    this.onIconTap,
    this.controller,
    this.errorText,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.textMain,
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              errorText: errorText,

              prefixIcon: prefix,
              suffixIcon: GestureDetector(
                onTap: onIconTap,
                child: Icon(icon),
              ),

              filled: true,
              fillColor: fillColor ?? Colors.grey.shade100,

              contentPadding: const EdgeInsets.symmetric(
                vertical: 14,
                horizontal: 16,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
              ),

              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: Colors.grey.shade400,
                ),
              ),

              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.blue,
                  width: 1.5,
                ),
              ),

              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.red,
                ),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const BorderSide(
                  color: Colors.red,
                  width: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
