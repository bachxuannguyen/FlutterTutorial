///Sử dụng StreamProvider thay thế cho StreamBuilder
///StreamBuider: Nghe stream từ stream: stream, đọc giá trị từ builder - snapshot
///StreamProvider: Nghe stream từ create: (_) {createStream}
///StreamProvider.value: Nghe stream từ value: stream
///StreamProvider nói chung: Đọc giá trị từ Consumer - buider - provider value

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:provider/provider.dart';

class FSignIn extends StatefulWidget {
  const FSignIn({super.key});

  @override
  State<FSignIn> createState() => _FSignInState();
}

class _FSignInState extends State<FSignIn> {
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
              onChanged: (text) => bloc.phoneSink.add(text),
            ),
            TextField(
              onChanged: (text) => bloc.passSink.add(text),
            ),
            StreamProvider<bool>.value(
              value: bloc.buttonStream,
              initialData: false,
              child: Consumer<bool>(
                builder: (context, enable, child) {
                  return ElevatedButton(
                    onPressed: enable ? () {} : null,
                    child: const Text("Click Me"),
                  );
                }
              ),
            ),
            StreamProvider<bool>(
              create: (_) => bloc.buttonStream,
              initialData: false,
              child: Consumer<bool>(
                builder: (context, enable, child) {
                  return ElevatedButton(
                    onPressed: enable ? () {} : null,
                    child: const Text("Click Me Too"),
                  );
                  },
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

  final _phoneSubject = BehaviorSubject<String>();
  Sink<String> get phoneSink => _phoneSubject.sink;
  final _passSubject = BehaviorSubject<String>();
  Sink<String> get passSink => _passSubject.sink;
  final _buttonSubject = BehaviorSubject<bool>();
  Stream<bool> get buttonStream => _buttonSubject.stream;

  void handleButton() {
    Rx.combineLatest2(
      _phoneSubject, _passSubject, (phone, pass) {
      return isValid(phone, pass);
    },
    ).listen((enable) {
      _buttonSubject.add(enable);
    });
  }

  bool isValid(String phone,String pass)
  {
    return phone.length >= 3 && pass.length >= 3;
  }
}