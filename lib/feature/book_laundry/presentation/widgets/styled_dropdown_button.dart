import 'package:flutter/material.dart';

class StyledDropdownButton extends StatelessWidget {
  const StyledDropdownButton({
    super.key,
    required this.selectedValue,
    required this.values,
    required this.onChanged,
    required this.hintText,
    this.margin,
  });

  final dynamic selectedValue;
  final List<DropdownMenuItem> values;
  final void Function(dynamic)? onChanged;
  final String hintText;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(4),
      margin: margin,
      child: DropdownButton(
        isExpanded: true,
        focusColor: Colors.red,
        value: selectedValue,
        hint: Text(hintText),
        icon: const Icon(Icons.expand_more),
        iconSize: 32,
        iconDisabledColor: Colors.grey,
        iconEnabledColor: Colors.black,
        underline: const SizedBox(),
        items: values,
        onChanged: onChanged,
      ),
    );
  }
}
