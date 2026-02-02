import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../features/core/app_colors.dart';

enum FieldType {
  text,
  email,
  password,
  phone,
}


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
  final FieldType fieldType;

  final String? Function(String?)? validator;


  final bool isPhone;
  final Function(PhoneNumber)? onPhoneChanged;
  final PhoneNumber? initialPhone;

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
    this.validator,
    this.isPhone = false,
    this.onPhoneChanged,
    this.initialPhone,
    this.fieldType = FieldType.text,

  });

  @override
  Widget build(BuildContext context) {

    Widget field;

    if (isPhone) {
      field = InternationalPhoneNumberInput(
        initialValue: initialPhone ?? PhoneNumber(isoCode: 'KE'),
        onInputChanged: (number) {
          onPhoneChanged?.call(number);
        },
        selectorConfig: const SelectorConfig(
          selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
        ),
        autoValidateMode: AutovalidateMode.onUserInteraction,
        formatInput: true,

        inputDecoration: InputDecoration(
          hintText: hint,
          errorText: errorText,
          prefixIcon: prefix,
          suffixIcon: GestureDetector(
            onTap: onIconTap,
            child: Icon(icon),
          ),
          filled: true,
          fillColor: fillColor ?? Colors.grey.shade100,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),


        validator: validator ?? _defaultValidator,
      );

    } else {
      field = TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        validator: validator,
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
          contentPadding:
          const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      );
    }

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
          field,
        ],
      ),
    );
  }
  String? _defaultValidator(String? value) {

    switch (fieldType) {

      case FieldType.email:
        if (value == null || value.isEmpty) {
          return 'Email is required';
        }

        final emailRegex =
        RegExp(r'^[\w\.\-]+@([\w\-]+\.)+[a-zA-Z]{2,}$');

        if (!emailRegex.hasMatch(value.trim())) {
          return 'Enter a valid email';
        }
        return null;

      case FieldType.password:
        if (value == null || value.isEmpty) {
          return 'Password is required';
        }

        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }

        return null;

      case FieldType.phone:
        if (value == null || value.isEmpty) {
          return 'Phone number is required';
        }
        return null;

      default:
        if (value == null || value.isEmpty) {
          return 'This field is required';
        }
        return null;
    }
  }

}

