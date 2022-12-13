///***BLoC
///Khởi tạo đối tượng _controller = StreamController()
///Khởi tạo đối tượng stream = _controller.stream, để được dùng bên UI
///Viết phương thức để sẵn sàng được gọi từ UI
///Trong đó
///---(1) xử lý tham số được truyền vào và
///---(2) gọi phương thức _controller.add(<event>) để đẩy dữ liệu vào stream
///***UI
///Sử dụng StreamBuilder để đọc dữ liệu từ một stream
///Gọi và truyền tham số vào phương thức của BLoC

import 'dart:async';
import 'package:flutter/material.dart';

class BIncrement extends StatefulWidget {
  const BIncrement({super.key});

  @override
  State<BIncrement> createState() => _BIncrementState();
}

class _BIncrementState extends State<BIncrement> {
  Bloc bloc = Bloc();

  @override
  void initState() {
    bloc = Bloc();
    super.initState();
  }

  @override
  void dispose() {
    bloc.closeStream();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Stream'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ValueDisplay(
              stream: bloc.stream,
            ),
            const SizedBox(height: 15,),
            ElevatedButton(
              onPressed: () {
                bloc.handleClickEvent(1);
                },
              child: const Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class ValueDisplay extends StatelessWidget {
  final Stream<int> stream;
  const ValueDisplay({super.key, required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasError) return Text(snapshot.error.toString());
        if (snapshot.data == null) return const Text('Null');
        if (snapshot.hasData) return Text('${snapshot.data}', style: const TextStyle(fontSize: 40,));
        return const Text('Something went wrong.');
        },
    );
  }
}

///

class Bloc {
  int value = 0;
  final _controller = StreamController<int>.broadcast();
  Stream<int> get stream => _controller.stream;

  void handleClickEvent(int event) {
    value += event;
    _controller.add(value);
  }

  void closeStream() {
    _controller.close();
  }
}