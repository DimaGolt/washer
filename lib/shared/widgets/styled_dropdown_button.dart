import 'package:flutter/material.dart';
import 'package:washer/shared/widgets/conditional_builder.dart';

class StyledDropdownButton<T> extends StatelessWidget {
  const StyledDropdownButton({
    super.key,
    required this.selectedValue,
    required this.values,
    required this.onChanged,
    required this.hintText,
    this.margin,
    this.leading,
    this.icon,
    this.isPrimary = false,
    this.isExpanded = true,
    this.isTransparent = false,
  });

  final T? selectedValue;
  final List<DropdownMenuItem<T>> values;
  final void Function(T?)? onChanged;
  final String hintText;
  final EdgeInsets? margin;
  final Widget? leading;
  final Widget? icon;
  final bool isPrimary;
  final bool isTransparent;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    var primaryColor = Theme.of(context).primaryColor;

    return Container(
      decoration: BoxDecoration(
          color: isTransparent ? null : Colors.white, borderRadius: BorderRadius.circular(8)),
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
        child: DropdownButton<T>(
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
          icon: icon ?? const Icon(Icons.expand_more),
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
