// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:rambo/theme.dart';
import 'package:flutter/material.dart';

class BijakScreen extends StatefulWidget {
  const BijakScreen({Key? key}) : super(key: key);

  @override
  State<BijakScreen> createState() => _BijakScreenState();
}

class _BijakScreenState extends State<BijakScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bg2Color,
        title: const Text("Kebijakan Aplikasi"),
        actions: const [],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Kebijakan Aplikasi",
                style: primaryTextStyle.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."),
            ],
          ),
        ),
      ),
    );
  }
}
