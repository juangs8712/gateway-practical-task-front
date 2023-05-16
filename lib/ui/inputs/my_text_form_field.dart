import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:gateway/ui/inputs/custom_inputs_decorations.dart';

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
class MyTextFormField extends StatelessWidget {
  /// TextFormField personalizado con bordes rectangulares.
  const MyTextFormField({
    Key? key, 
    required this.label, 
    required this.hint, 
    this.readOnly = false, 
    this.prefix, 
    this.suffix, 
    this.helperText, 
    this.style,
    this.keyboardType, 
    this.controller, 
    this.onChanged, 
    this.validator, 
    this.inputFormatters,
  }) : super(key: key);

  final Widget     label;
  final String     hint;
  final bool       readOnly;
  final Widget?    prefix;
  final Widget?    suffix;
  final String?    helperText;
  final TextStyle? style;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final void    Function( String value )? onChanged;
  final String? Function(String? value )? validator;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric( horizontal: 10 ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          label,
          TextFormField(
            controller: controller,
            style: style,
            readOnly: readOnly,
            onChanged: onChanged,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatters,
            decoration: CustomInputDecorations.rectInputDecoration(
              hint: hint,
              helperText: helperText,
              prefix: prefix,
              suffix: suffix ),
          ),
        ],
      ),
    );
  }
}
// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~