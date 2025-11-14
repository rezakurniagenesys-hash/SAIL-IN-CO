import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

/// 🔹 Tambahkan textarea ke dalam enum
enum AppInputType { text, number, date, textarea }

class AppInputField extends StatelessWidget {
  final String? title;
  final String? label;
  final String? hintText;
  final TextEditingController? controller;
  final AppInputType type;
  final double height;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final bool readOnly;
  final Color borderSideColor;

  const AppInputField({
    super.key,
    this.label,
    this.title,
    this.hintText,
    this.controller,
    this.type = AppInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.height = 42,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.borderSideColor = AppColors.neutral300,
  });

  Future<void> _selectDate(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if (picked != null && controller != null) {
      controller!.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDateType = type == AppInputType.date;
    final isTextArea = type == AppInputType.textarea;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title?.isNotEmpty == true) ...[Text(title ?? '', style: AppTextStyles.body3Regular), SizedBox(height: 6)],
        SizedBox(
          height: isTextArea ? null : height,
          child: TextFormField(
            controller: controller,
            keyboardType: type == AppInputType.number ? TextInputType.number : TextInputType.multiline,
            obscureText: obscureText,
            onChanged: onChanged,
            validator: validator,
            readOnly: readOnly || isDateType,
            onTap: isDateType ? () => _selectDate(context) : null,
            maxLines: isTextArea ? 4 : 1,
            minLines: isTextArea ? 3 : 1,
            style: const TextStyle(fontSize: 13, color: Colors.black),
            decoration: InputDecoration(
              labelText: label?.isNotEmpty == true ? label : null,
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.neutral400, fontSize: 12),
              labelStyle: const TextStyle(color: AppColors.neutral400, fontSize: 14),
              floatingLabelStyle: const TextStyle(color: AppColors.sky950, fontWeight: FontWeight.w600, fontSize: 13),
              filled: true,
              fillColor: AppColors.white,
              alignLabelWithHint: isTextArea,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: isTextArea
                    ? 16
                    : (height <= 36
                          ? 8
                          : height <= 44
                          ? 10
                          : 14),
              ),
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,

              // Border default
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: borderSideColor, width: 1),
              ),

              // Border fokus
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.sky950, width: 1.5),
              ),

              // Border error
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),

              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
