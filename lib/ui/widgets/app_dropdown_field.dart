import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

class AppDropdownField extends StatefulWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String? label;
  final String? hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final Color borderSideColor;

  const AppDropdownField({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.hintText,
    this.validator,
    this.enabled = true,
    this.borderSideColor = AppColors.neutral300,
  });

  @override
  State<AppDropdownField> createState() => _AppDropdownFieldState();
}

class _AppDropdownFieldState extends State<AppDropdownField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: FocusScope(
        onFocusChange: (hasFocus) {
          setState(() => _isFocused = hasFocus);
        },
        child: DropdownButtonFormField<String>(
          value: widget.value?.isNotEmpty == true ? widget.value : null,
          validator: widget.validator,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.sky950),
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hintText,
            hintStyle: const TextStyle(color: AppColors.neutral400, fontSize: 13),
            labelStyle: AppTextStyles.body4Medium.copyWith(color: _isFocused ? AppColors.sky950 : AppColors.neutral400, fontSize: 13),
            floatingLabelStyle: AppTextStyles.body4Medium.copyWith(color: AppColors.sky950, fontWeight: FontWeight.w600),
            filled: true,
            fillColor: widget.enabled ? AppColors.white : AppColors.neutral100,
            contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: widget.borderSideColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: AppColors.sky950, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
          ),
          dropdownColor: Colors.white,
          menuMaxHeight: 250,
          borderRadius: BorderRadius.circular(10),
          elevation: 3,
          items: widget.items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item, style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary, fontSize: 13)),
            );
          }).toList(),
          onChanged: widget.enabled ? widget.onChanged : null,
          style: AppTextStyles.body4Reguler.copyWith(color: AppColors.textPrimary, fontSize: 13),
        ),
      ),
    );
  }
}
