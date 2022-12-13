///Sử dụng Rx.CombineLatest2 để nghe dữ liệu từ 2 stream
///Sau đó xử lý dữ liệu từ 2 stream này
///Và đẩy kết quả vào 1 stream mới

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ESignIn extends StatefulWidget {
  const ESignIn({super.key});

  @override
  State<ESignIn> createState() => _ESignInState();
}

class _ESignInState extends State<ESignIn> {
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
            StreamBuilder<bool>(
              initialData: false,
              stream: bloc.buttonStream,
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