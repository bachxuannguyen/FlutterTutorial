import 'package:flutter/material.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/a_set_state.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/b_basic_stream_builder.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/c_basic_stream_builder.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/d_basic_stream_builder.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/e_combine_stream_builders.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/f_combine_stream_providers.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/g_combine_stream_providers.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/h_change_notifier_provider.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/i_future_provider.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/j_multi_provider.dart';
import 'package:flutter_tutorial/basic_provider_bloc_stream/k_proxy_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      //home: const KFileInfo(),
      home: const AShoppingList(
          products: [
            Product(name: "Grape"),
            Product(name: "Apple"),
            Product(name: "Potato"),
          ]
      ),
    );
  }
}
