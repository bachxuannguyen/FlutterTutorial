///Model FileInfo phụ thuộc vào model File
///Tạo MultiProvider để nạp các model này vào UI
///Model File: Nạp bình thường bằng Provider
///---Trong đó khởi tạo đối tượng File()
///Model FileService: Nạp sử dụng ProxyProvider
///---Trong đó khởi tạo đối tượng FileService(File file)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KFileInfo extends StatelessWidget {
  const KFileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<File>(
          create: (context) => File(),
        ),
        ProxyProvider<File, FileService>(
          update: (context, file, fileService) => FileService(file: file),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("File Info")),
        body: Consumer<FileService>(
          builder: (context, fileService, child) => Text(
            fileService.getFileInfo(),
          ),
        ),
      ),
    );
  }
}

///

class File {
  String name = "file_01.txt";
  String type = "Text";
}

class FileService {
  File file = File();
  FileService({ required this.file });
  String getFileInfo() {
    return "File info: ${file.name} (${file.type})";
  }
}