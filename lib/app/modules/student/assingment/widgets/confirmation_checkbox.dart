// lib/modules/assignments/widgets/confirmation_checkbox.dart
import 'package:flutter/material.dart';
import '../../../../theme/app_colors.dart';

class ConfirmationCheckbox extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool?> onChanged;

  const ConfirmationCheckbox({
    super.key,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // This widget now receives the value from the controller and calls onChanged
    return CheckboxListTile(
      title: Text(text, style: const TextStyle(color: AppColors.textColor)),
      value: value,
      onChanged: onChanged,
      controlAffinity: ListTileControlAffinity.leading,
      dense: true,
      contentPadding: EdgeInsets.zero,
      activeColor: AppColors.primaryColor,
    );
  }
}