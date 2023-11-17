import 'package:flutter/material.dart';
import 'package:washer/shared/widgets/conditional_builder.dart';

import 'conditional_builder.dart';

class StyledDropdownButton extends StatelessWidget {
  const StyledDropdownButton({
    super.key,
    required this.selectedValue,
    required this.values,
    required this.onChanged,
    required this.hintText,
    this.margin,
    this.leading,
    this.isPrimary = false,
  });

  final dynamic selectedValue;
  final List<DropdownMenuItem> values;
  final void Function(dynamic)? onChanged;
  final String hintText;
  final EdgeInsets? margin;
  final Widget? leading;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.all(4),
      margin: margin,
      child: ConditionalBuilder(
        condition: leading != null,
        builder: (_, child) => Row(
          children: [
            Container(
              constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
              child: leading!,
            ),
            const SizedBox(width: 30),
            Expanded(child: child),
          ],
        ),
        child: DropdownButton(
          isExpanded: true,
          focusColor: Colors.red,
          value: selectedValue,
          hint: Text(
            hintText,
            style: TextStyle(
              color: isPrimary ? primaryColor : null,
              fontSize: isPrimary ? 24 : null,
            ),
          ),
          icon: const Icon(Icons.expand_more),
          iconSize: 32,
          iconDisabledColor: Colors.grey,
          iconEnabledColor: isPrimary ? primaryColor : Colors.black,
          underline: isPrimary ? Container(height: 1, color: primaryColor) : const SizedBox(),
          items: values,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
