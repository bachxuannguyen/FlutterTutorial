///MultiProvider: Nạp nhiều model vào cùng một context

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class JChangeProfile extends StatelessWidget {
  const JChangeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserName>(
            create: (context) => UserName(),
        ),
        ChangeNotifierProvider<UserAge>(
            create: (context) => UserAge(),
        )
      ],
      child: Scaffold(
        appBar: AppBar(title: const Text("Change Profile")),
        body: Column(
          children: [
            Consumer<UserName>(
              builder: (context, userName, child) => Row(
                children: [
                  ElevatedButton(
                    child: const Text("Choose a name"),
                    onPressed: () { userName.getName(); },
                  ),
                  const SizedBox(width: 15),
                  Text(userName.value.toString()),
                ],
              ),
            ),
            Consumer<UserAge>(
              builder: (context, userAge, child) => Row(
                children: [
                  ElevatedButton(
                    child: const Text("Choose an age"),
                    onPressed: () { userAge.getAge(); },
                  ),
                  const SizedBox(width: 15),
                  Text(userAge.value.toString()),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

///

class UserName with ChangeNotifier {
  String value = "Bill";
  void getName() {
    if (value == "Bill") {
      value = "Bob";
    } else {
      value = "Bill";
    }
    notifyListeners();
  }
}

class UserAge with ChangeNotifier {
  int value = 0;
  void getAge() {
    value += 5;
    notifyListeners();
  }
}