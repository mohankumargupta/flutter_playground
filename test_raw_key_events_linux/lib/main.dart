import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
/*
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Container()
          /*RawKeyboardListener(
          child: TextField(),
          focusNode: FocusNode(),
          onKey: (RawKeyEvent event) async {
            //if (event.runtimeType == RawKeyDownEvent) {
            debugPrint(
                'id: ${event.logicalKey.keyId}, label: ${event.logicalKey.keyLabel} debugName: ${event.logicalKey.debugName} keycode: ${event.toString()}');
            //}
          },
        ),*/
          ),
    );
  }
*/
  @override
  State<MyApp> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    HardwareKeyboard.instance.addHandler((KeyEvent event) {
      print(event);
      return false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
