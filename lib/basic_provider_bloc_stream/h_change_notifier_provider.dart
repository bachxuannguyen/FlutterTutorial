///UI và BLoC có thể tương tác mà ko dùng stream
///ChangeNotifier: lớp đối tượng với phương thức notifyListener()
///ChangeNotifierProvider:
///---Lấy được instance của đối tượng ChangeNotifier
///---Và tự động cập nhật widget theo đánh động từ ChangeNotifier

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HIncrement extends StatefulWidget {
  const HIncrement({super.key});

  @override
  State<HIncrement> createState() => _IncrementState();
}

class _IncrementState extends State<HIncrement> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Change Notifier Provider"),
      ),
      body: ChangeNotifierProvider(
        create: (_) => Counter(),
        child: Consumer<Counter>(
          builder: (context, counter, child) => Column(
            children: [
              Text(
                '${counter.value}',
                style: const TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                onPressed: () => counter.increment(),
                child: const Text(
                  "Increment",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

///

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    value++;
    notifyListeners();
  }
}