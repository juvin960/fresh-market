
import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledField extends StatelessWidget {
  const LabeledField({
    required this.label,
    required this.child,
    this.footer,
  });

  final String label;
  final Widget child;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.grey[200] : AppColors.textMain,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.centerRight,
          children: [
            child,
          ],
        ),
        if (footer != null) ...[
          const SizedBox(height: 6),
          footer!,
        ],
      ],
    );
  }
}
InputDecoration inputDecoration(
    BuildContext context, {
      required String hint,
      Widget? trailing,
    }) {
  final isDark = Theme.of(context).brightness == Brightness.dark;
  return InputDecoration(
    hintText: hint,
    filled: true,
    fillColor: isDark ? const Color(0xFF233523) : Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: isDark ? const Color(0xFF3A4E3A) : const Color(0xFFDCE5DC),
        width: 1,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: isDark ? const Color(0xFF3A4E3A) : const Color(0xFFDCE5DC),
        width: 1,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: AppColors.primary.withValues(alpha:0.5),
        width: 2,
      ),
    ),
    hintStyle: GoogleFonts.plusJakartaSans(
      color: isDark ? Colors.grey[500] : AppColors.textSecondary,
    ),
    suffixIcon: trailing == null
        ? null
        : Padding(
      padding: const EdgeInsets.only(right: 8),
      child: trailing,
    ),
    suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
  );
}



