import 'package:flutter/material.dart';
import 'package:sail_in_co/core/theme/app_color.dart';
import 'package:sail_in_co/core/theme/app_text_styles.dart';

/// Mode picker (tanggal / bulan / tahun)
enum DatePickerType { day, month, year }

/// Custom DatePicker dengan tema dominan AppColors.sky950
/// dan bisa membatasi tanggal yang tidak bisa dipilih.
/// [minDate] = tanggal minimum yang boleh dipilih.
/// jika null, default-nya adalah 1 Januari 2000.
/// [type] = mode picker (day, month, year)
Future<DateTime?> showAppDatePicker(BuildContext context, {DateTime? initialDate, DateTime? minDate, DatePickerType type = DatePickerType.day}) async {
  final DateTime now = DateTime.now();
  DateTime selectedDate = initialDate ?? now;
  final DateTime minAllowed = minDate ?? DateTime(2000);

  return showDialog<DateTime>(
    context: context,
    builder: (context) {
      return Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // --- Header ---
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(color: AppColors.sky950, borderRadius: BorderRadius.circular(12)),
                child: Text(
                  type == DatePickerType.day
                      ? "Pilih Tanggal"
                      : type == DatePickerType.month
                      ? "Pilih Bulan"
                      : "Pilih Tahun",
                  style: AppTextStyles.label2SemiBold.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),

              // --- Content Berdasarkan Mode ---
              if (type == DatePickerType.day)
                CalendarDatePicker(
                  initialDate: selectedDate.isBefore(minAllowed) ? minAllowed : selectedDate,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                  onDateChanged: (date) => selectedDate = date,
                  selectableDayPredicate: (day) {
                    // ❌ Disable semua tanggal sebelum minAllowed
                    return !day.isBefore(minAllowed);
                  },
                )
              else if (type == DatePickerType.month)
                _MonthPicker(initialDate: selectedDate, onSelected: (date) => selectedDate = date)
              else if (type == DatePickerType.year)
                _YearPicker(initialDate: selectedDate, onSelected: (date) => selectedDate = date),

              const SizedBox(height: 8),
              const Divider(height: 1),

              // --- Action Buttons ---
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Batal", style: AppTextStyles.body3Medium.copyWith(color: AppColors.neutral400)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.sky950,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      ),
                      onPressed: () => Navigator.pop(context, selectedDate),
                      child: Text("Pilih", style: AppTextStyles.body3Medium.copyWith(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// --- Custom Month Picker ---
class _MonthPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onSelected;

  const _MonthPicker({required this.initialDate, required this.onSelected});

  @override
  State<_MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<_MonthPicker> {
  late int selectedMonth;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialDate.month;
  }

  @override
  Widget build(BuildContext context) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'Mei', 'Jun', 'Jul', 'Agu', 'Sep', 'Okt', 'Nov', 'Des'];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      children: List.generate(12, (i) {
        final isSelected = selectedMonth == (i + 1);
        return GestureDetector(
          onTap: () {
            setState(() => selectedMonth = i + 1);
            widget.onSelected(DateTime(widget.initialDate.year, i + 1, 1));
          },
          child: Container(
            width: 70,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.sky950 : AppColors.neutral100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: isSelected ? AppColors.sky950 : AppColors.neutral300),
            ),
            alignment: Alignment.center,
            child: Text(months[i], style: AppTextStyles.body3Medium.copyWith(color: isSelected ? Colors.white : AppColors.textPrimary)),
          ),
        );
      }),
    );
  }
}

/// --- Custom Year Picker ---
class _YearPicker extends StatefulWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onSelected;

  const _YearPicker({required this.initialDate, required this.onSelected});

  @override
  State<_YearPicker> createState() => _YearPickerState();
}

class _YearPickerState extends State<_YearPicker> {
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedYear = widget.initialDate.year;
  }

  @override
  Widget build(BuildContext context) {
    final currentYear = DateTime.now().year;
    final years = List.generate(50, (i) => currentYear - i);

    return SizedBox(
      height: 250,
      child: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, i) {
          final year = years[i];
          final isSelected = year == selectedYear;
          return ListTile(
            dense: true,
            title: Text(
              year.toString(),
              style: AppTextStyles.body3Medium.copyWith(
                color: isSelected ? AppColors.sky950 : AppColors.textPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
            onTap: () {
              setState(() => selectedYear = year);
              widget.onSelected(DateTime(year, widget.initialDate.month, 1));
            },
          );
        },
      ),
    );
  }
}

// // Pilih tanggal normal
// await showAppDatePicker(context, type: DatePickerType.day);

// // Pilih bulan
// await showAppDatePicker(context, type: DatePickerType.month);

// // Pilih tahun
// await showAppDatePicker(context, type: DatePickerType.year);

// // Batasi tanggal minimum
// await showAppDatePicker(
//   context,
//   minDate: DateTime(2025, 11, 13),
// );
