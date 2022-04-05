import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
export 'package:portaventory/components/form_fields/validator/form_validator.dart';

class TextfieldWidget extends StatelessWidget {
  const TextfieldWidget({
    Key? key,
    required this.placeholder,
    required this.controller,
    this.editable = true,
    this.hint = '',
    this.suffixIcon,
    this.prefix,
    this.helperText,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.inputFormatters,
    this.onChange,
  }) : super(key: key);

  final String placeholder;
  final TextEditingController controller;
  final String hint;
  final String? helperText;
  final Widget? suffixIcon;
  final Widget? prefix;
  final void Function()? onTap;
  final ValueChanged<String>? onChange;
  final bool editable;
  final TextInputType keyboardType;

  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      autocorrect: false,
      validator: validator,
      inputFormatters: inputFormatters,
      maxLines: keyboardType == TextInputType.multiline ? null : 1,
      decoration: InputDecoration(
        prefixIcon: prefix,
        suffixIcon: suffixIcon,
        labelText: placeholder.tr,
        helperMaxLines: 3,
        helperText: helperText,
        hintText: hint,
      ),
      enabled: editable,
      onTap: onTap,
      onChanged: (String text) {
        if (onChange != null) {
          onChange!(text);
        }
      },
    );
  }
}
