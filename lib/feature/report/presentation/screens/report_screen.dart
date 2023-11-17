import 'package:flutter/material.dart';
import 'package:washer/app/router.dart';
import 'package:washer/shared/widgets/appbar_wave.dart';
import 'package:washer/shared/widgets/washer_scroll_view.dart';

import '../../../../shared/widgets/styled_dropdown_button.dart';

@RoutePage()
class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  bool enableDescription = true;
  String? _pickedItem;
  List<String> _items = ['woo', 'waa', 'wee'];

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const AppBarWave(
        title: 'Report machine',
      ),
      floatingActionButton: _fab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: WasherScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Place:',
                style: TextStyle(color: theme.primaryColor, fontSize: 32),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 17.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
                    child: Column(
                      children: [
                        StyledDropdownButton(
                          selectedValue: _pickedItem,
                          values: _items
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (type) {
                            if (_pickedItem != type) {
                              _pickedItem = type;
                              setState(() {});
                            }
                          },
                          hintText: 'Choose dorm',
                          isPrimary: true,
                        ),
                        StyledDropdownButton(
                          selectedValue: _pickedItem,
                          values: _items
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (type) {
                            if (_pickedItem != type) {
                              _pickedItem = type;
                              setState(() {});
                            }
                          },
                          hintText: 'Choose floor',
                          isPrimary: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Machine nr.: '),
                              Container(
                                height: 42,
                                width: 120,
                                decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0xFFA3A3A3),
                                    ),
                                    BoxShadow(
                                        color: Color(0xFFD9D9D9),
                                        blurRadius: 10,
                                        spreadRadius: -1,
                                        blurStyle: BlurStyle.inner),
                                  ],
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'What\'s wrong:',
                  style: TextStyle(color: theme.primaryColor, fontSize: 24),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Checkbox(
                              value: !enableDescription,
                              onChanged: (_) {
                                setState(() {
                                  enableDescription = !enableDescription;
                                });
                              }),
                          const Text('I\'m not sure'),
                        ],
                      ),
                      Container(
                        height: 320,
                        decoration: BoxDecoration(
                          color:
                              enableDescription ? const Color(0xBAEBEBEB) : const Color(0xBAEBEBEB),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          maxLines: null,
                          expands: true,
                          enabled: enableDescription,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              hintText: 'Write what happened',
                              hintStyle: TextStyle(
                                  color: enableDescription
                                      ? theme.primaryColor
                                      : const Color(0x4A6896AD))),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _fab() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
        child: Container(
          constraints: const BoxConstraints(minWidth: double.infinity, maxHeight: 58),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFFF86666)),
            child: Center(
              child: const Text(
                'Report',
                style: TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      );
}
