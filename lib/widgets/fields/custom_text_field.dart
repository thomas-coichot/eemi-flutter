import 'package:flutter/material.dart';
import 'package:flutter_5_wd/widgets/fields/input_decoration.dart';

import '../../services/validator_service.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    this.required = true,
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final bool required;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(
        colorScheme: colorScheme,
        label: label,
      ),
      validator: (String? value) {
        final isRequired = ValidatorService.isRequired(value);

        if (required && isRequired != null) {
          return isRequired;
        }

        return null;
      },
    );
  }
}
