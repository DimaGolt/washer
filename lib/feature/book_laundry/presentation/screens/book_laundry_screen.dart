import 'package:auto_route/auto_route.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

@RoutePage()
class BookLaundryScreen extends StatelessWidget {
  const BookLaundryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Book Laundry'),
      ),
      body: Container(
        color: Theme.of(context).primaryColor,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    DropdownButton2(
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white)))),
                      iconStyleData: IconStyleData(
                        icon: Icon(Icons.expand_more),
                        iconSize: 32,
                        iconEnabledColor: Colors.white,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'we',
                          child: Text('we'),
                        ),
                        DropdownMenuItem(
                          value: 'wee',
                          child: Text('wee'),
                        ),
                      ],
                      onChanged: (_) {},
                    ),
                    DropdownButton2(
                      isExpanded: true,
                      buttonStyleData: const ButtonStyleData(
                          decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: Colors.white)))),
                      iconStyleData: const IconStyleData(
                        icon: Icon(Icons.expand_more),
                        iconSize: 32,
                        iconEnabledColor: Colors.white,
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'we',
                          child: Text('we'),
                        ),
                        DropdownMenuItem(
                          value: 'wee',
                          child: Text('wee'),
                        ),
                      ],
                      onChanged: (_) {},
                    ),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16), topRight: Radius.circular(16))),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
