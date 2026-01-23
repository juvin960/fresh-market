import 'package:flutter/material.dart';
import 'package:fresh_market_app/features/core/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class DividerLabel extends StatelessWidget {
  const DividerLabel({required this.label, required this.backgroundColor});
  final String label;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.light;
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(
          height: 32,
          thickness: 1,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          color: backgroundColor,
          child: Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}