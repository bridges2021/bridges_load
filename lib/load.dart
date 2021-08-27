import 'package:bridges_load/LoadView.dart';
import 'package:flutter/material.dart';

Future<void> load(BuildContext context,
    {required Future Function() load, Function()? whenComplete,
     Function()? whenFail}) async {
  await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LoadView(
                load: load,
                whenComplete: whenComplete,
                whenFail: whenFail,
              )));
}
