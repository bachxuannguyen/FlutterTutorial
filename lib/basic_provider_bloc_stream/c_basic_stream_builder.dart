///Bài trước: onPressed: () { bloc.handleClickEvent(1); }
///Bài này: onChanged: (text) {bloc.handleChecking(text); }

import 'dart:async';
import 'package:flutter/material.dart';

class CTextboxValidating extends StatefulWidget {
  const CTextboxValidating({super.key});

  @override
  State<CTextboxValidating> createState() => _CTextboxValidatinggState();
}

class _CTextboxValidatinggState extends State<CTextboxValidating> {
  Bloc bloc = Bloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Textbox Validating"),
      ),
      body: StreamBuilder<String>(
        initialData: "",
        stream: bloc.validatingStream,
        builder: (context, snapshot) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            onChanged: (text) {
              bloc.handleChecking(text);
              },
            decoration: InputDecoration(
              errorText: snapshot.data,
            ),
          ),
        ),
      ),
    );
  }
}

///

class Bloc {
  final _validatingController = StreamController<String>();
  Stream<String> get validatingStream => _validatingController.stream;

  void handleChecking(String text) {
    text.length > 6 ?
    _validatingController.add("") :
    _validatingController.add("Invalid string");
  }
}