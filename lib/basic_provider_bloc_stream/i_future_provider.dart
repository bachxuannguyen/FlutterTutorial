///Việc tải file qua mạng có thể mất nhiều thời gian
///Hiển thị "Waiting..." khi việc tải file chưa hoàn tất
///Hiển thị "File loaded" khi việc tải file hoàn tất
///Sau đó UI sẽ ko tiếp tục cập nhật dữ liệu theo model
///(Như với StreamProvider hoặc ChangeNotifierProvider)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IFileLoading extends StatelessWidget {
  const IFileLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<File>(
      create: (context) => getFile(),
      initialData: File(
        fileStatus: "Waiting...",
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("File Upload"),
        ),
        body: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Consumer<File>(
              builder: (context, file, child) => Text(
                file.fileStatus,
              ),
            ),
            Consumer<File>(
              builder: (context, file, child) => ElevatedButton(
                onPressed: () {
                  file.setStatus();
                  },
                child: const Text(
                  "Click Me",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///

class File {
  File({required this.fileStatus});
  String fileStatus = ".";
  void setStatus() {
    fileStatus = "Status Changed";
  }
}

Future<File> getFile() async {
  await Future.delayed(const Duration(seconds: 5));
  return File(fileStatus: "File Loaded");
}