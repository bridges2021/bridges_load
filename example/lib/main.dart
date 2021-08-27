import 'package:flutter/material.dart';
import 'package:bridges_load/bridges_load.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.blue,
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.headline6,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))))),
      home: _MainView(),
    );
  }
}

class _MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Load something'),
          onPressed: () {
            load(
              context,
              load: () async {
                await Future.delayed(Duration(seconds: 2));
              },
            );
          },
        ),
      ),
    );
  }
}
