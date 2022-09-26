import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() {
  final channel =
      IOWebSocketChannel.connect('ws://192.168.20.98:8123/api/websocket');
  Stream boo = channel.stream.asBroadcastStream();

  print("Start message sent");
  channel.sink.add(
      '{"type":"auth", "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiIzZWM3ZDQ5OWRjNDg0NTdhYjAyZmQ5Mjk4MTNmOGY0MCIsImlhdCI6MTY2NDAwMzI2OSwiZXhwIjoxOTc5MzYzMjY5fQ.C3U4RkiPgHYCj7Brd2OGvNqS_aIoXFI0q7G2sMm2T4U"}');
  channel.sink.add('{"type": "config/device_registry/list", "id":1 }');
  channel.sink.add('{"type": "config/entity_registry/list", "id":2 }');
  channel.sink.add('{"type": "config/area_registry/list", "id":3 }');
  channel.sink.add('{"type": "get_states", "id":4 }');
  //channel.sink.add('{"type":"auth", "access_token": "e"}');
  print("End message sent");
  channel.stream.listen((message) {
    print("Message received:");
    //print(message);
    Map<String, dynamic> map = jsonDecode(message);
    String type = map["type"];

    if (type == "auth_invalid") {
      print(map["message"]);
    } else if (type == "auth_ok") {
      String version = map["ha_version"];
      print("HA version $version");
      print("Authenticated successfully");
    } else {
      bool? success = map["success"];
      if (success == true) {
        int id = map["id"];
        print(id);
        Map<String, dynamic> map2 = jsonDecode(message);
        List<dynamic> result = map2["result"];
        switch (id) {
          case 1:
            final devices = result
                .where((element) =>
                    element["model"] != "Home Assistant Add-on" &&
                    element["model"] != null &&
                    element["manufacturer"] != "hacs.xyz" &&
                    element["manufacturer"] != "Home Assistant")
                .toList();
            print("----START DEVICES---");
            for (final device in devices) {
              final name = device["name"];
              final manufacturer = device["manufacturer"];
              final model = device["model"];
              print("Name:$name Model: $manufacturer $model   ");
            }
            print("----END DEVICES---");
            break;
          case 2:
            print("---START ENTITIES---");
            print(result);
            print("---END ENTITIES---");
            break;
          case 3:
            print("---START AREAS---");
            print(result);
            print("---END AREAS---");
            break;
          case 4:
            print("---START STATES---");
            print(result);
            print("---END STATES---");
            break;
          default:
        }
      }
    }

    //channel.sink.close(status.goingAway);
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
