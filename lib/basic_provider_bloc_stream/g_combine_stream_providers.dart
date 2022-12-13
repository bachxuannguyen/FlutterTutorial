///Như bài trước, xử lý thêm sự kiện onPressed của ElevatedButton
///onPressed: (enable)
///? () { bloc.handleClick(text 1, text 2); }
///: null

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

class GCalculator extends StatefulWidget {
  const GCalculator({super.key});

  @override
  State<GCalculator> createState() => _GCalculatorState();
}

class _GCalculatorState extends State<GCalculator> {
  Bloc bloc = Bloc();
  final _textOneController = TextEditingController();
  final _textTwoController = TextEditingController();

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
              controller: _textOneController,
              onChanged: (text) => bloc.oneSink.add(text),
            ),
            TextField(
              controller: _textTwoController,
              onChanged: (text) => bloc.twoSink.add(text),
            ),
            StreamProvider<bool>.value(
              value: bloc.buttonStream,
              initialData: false,
              child: Consumer<bool>(
                builder: (context, enable, child) => ElevatedButton(
                    onPressed: enable ? () {
                      bloc.handleClick(_textOneController.text, _textTwoController.text);
                    } : null,
                    child: const Text("Calculate"),
                  ),
              ),
            ),
            StreamProvider<int>(
              create: (_) => bloc.resultStream,
              initialData: 0,
              child: Consumer<int>(
                  builder: (context, result, child) {
                    return Text(
                      result.toString(),
                      style: const TextStyle(fontSize: 20),
                    );
                  }
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
  Bloc() {
    handleButton();
  }

  final _oneSubject = BehaviorSubject<String>();
  Sink<String> get oneSink => _oneSubject.sink;
  final _twoSubject = BehaviorSubject<String>();
  Sink<String> get twoSink => _twoSubject.sink;
  final _buttonSubject = BehaviorSubject<bool>();
  Stream<bool> get buttonStream => _buttonSubject.stream;
  final _resultSubject = BehaviorSubject<int>();
  Stream<int> get resultStream => _resultSubject.stream;

  void handleButton() {
    Rx.combineLatest2(
      _oneSubject, _twoSubject, (one, two) {
      return isValid(one, two);
    },
    ).listen((enable) {
      _buttonSubject.add(enable);
    });
  }

  void handleClick(String one,String two)
  {
    int? iOne = int.tryParse(one);
    int? iTwo = int.tryParse(two);
    if (iOne != null && iTwo != null) {
      _resultSubject.add(iOne + iTwo);
      return;
    }
    _resultSubject.add(0);
  }

  bool isValid(String one,String two)
  {
    int? iOne = int.tryParse(one);
    int? iTwo = int.tryParse(two);
    if (iOne != null && iTwo != null) return true;
    return false;
  }
}