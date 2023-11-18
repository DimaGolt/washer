import 'package:flutter/material.dart';

import '../../../../shared/widgets/styled_dropdown_button.dart';

class SettingsDropdown<T> extends StatelessWidget {
  const SettingsDropdown({
    super.key,
    required this.icon,
    required this.text,
    required this.onChanged,
    required this.items,
    required this.selectedItem,
    required this.itemBuilder,
  });

  final IconData icon;
  final String text;
  final Function(T?) onChanged;
  final List<T> items;
  final T selectedItem;
  final DropdownMenuItem<T> Function(T) itemBuilder;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Material(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 80,
            child: Row(
              children: [
                Icon(
                  icon,
                  color: theme.primaryColor,
                  size: 42,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(color: theme.primaryColor, fontSize: 20),
                    softWrap: true,
                    maxLines: 2,
                  ),
                ),
                const SizedBox(width: 20),
                Container(
                  height: 42,
                  width: 120,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x7FA3A3A3),
                      ),
                      BoxShadow(
                          color: Colors.white,
                          blurRadius: 10,
                          spreadRadius: -1,
                          blurStyle: BlurStyle.inner),
                    ],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: StyledDropdownButton<T>(
                      selectedValue: selectedItem,
                      values: items.map((e) => itemBuilder(e)).toList(),
                      onChanged: onChanged,
                      hintText: '',
                      isExpanded: false,
                      isTransparent: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
