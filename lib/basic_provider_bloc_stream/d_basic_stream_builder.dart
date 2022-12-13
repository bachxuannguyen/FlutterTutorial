///Như bài trước, kiểm soát dữ liệu từ TextField để bật tắt ElevatedButton

import 'dart:async';
import 'package:flutter/material.dart';

class DButtonValidating extends StatefulWidget {
  const DButtonValidating({super.key});

  @override
  State<DButtonValidating> createState() => _DButtonValidatingState();
}

class _DButtonValidatingState extends State<DButtonValidating> {
  Bloc bloc = Bloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Button Control"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            TextField(
              onChanged: (text) => bloc.handleButton(text),
            ),
            StreamBuilder<bool>(
              initialData: false,
              stream: bloc.controlStream,
              builder: (context, snapshot) => ElevatedButton(
                onPressed: (snapshot.data == true) ? () {} : null,
                child: const Text("Click Me"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///

class Bloc {
  final _controller = StreamController<bool>();
  Stream<bool> get controlStream => _controller.stream;

  void handleButton(String text) {
    text.length > 6 ?
    _controller.add(true) :
    _controller.add(false);
  }
}