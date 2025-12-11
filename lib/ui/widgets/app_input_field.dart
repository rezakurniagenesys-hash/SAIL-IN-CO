import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

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
    final now = DateTime.now();
    final picked = await showDatePicker(context: context, initialDate: now, firstDate: DateTime(2000), lastDate: DateTime(2100));

    if (picked != null && controller != null) {
      controller!.text = "${picked.day.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.year}";
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDateType = type == AppInputType.date;
    final isTextArea = type == AppInputType.textarea;

    return FormField<String>(
      validator: validator,
      builder: (field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title?.isNotEmpty == true)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(title!, style: AppTextStyles.body3Regular),
              ),

            // ================= INPUT =================
            SizedBox(
              height: isTextArea ? null : height,
              child: TextField(
                controller: controller,
                keyboardType: type == AppInputType.number ? TextInputType.number : TextInputType.multiline,
                obscureText: obscureText,
                readOnly: readOnly || isDateType,
                maxLines: isTextArea ? 4 : 1,
                minLines: isTextArea ? 3 : 1,
                onChanged: (value) {
                  onChanged?.call(value);
                  field.didChange(value);
                },
                onTap: isDateType ? () => _selectDate(context) : null,
                style: const TextStyle(fontSize: 13, color: Colors.black),
                decoration: InputDecoration(
                  labelText: label,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: AppColors.neutral400, fontSize: 12),
                  labelStyle: const TextStyle(color: AppColors.neutral400, fontSize: 14),
                  floatingLabelStyle: const TextStyle(color: AppColors.sky950, fontWeight: FontWeight.w600, fontSize: 13),

                  // ⬅ READONLY → warna abu-abu
                  filled: true,
                  fillColor: readOnly ? AppColors.neutral200 : AppColors.white,

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

                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(color: readOnly ? AppColors.neutral300 : borderSideColor, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.sky950, width: 1.5),
                  ),
                ),
              ),
            ),

            // ================= ERROR TEXT =================
            if (field.errorText != null)
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: Text(field.errorText!, style: const TextStyle(color: Colors.red, fontSize: 11)),
              ),
          ],
        );
      },
    );
  }
}
