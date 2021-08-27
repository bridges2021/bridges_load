import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum LoadStatus {
  Loading,
  Fail,
  Complete,
}

class LoadView extends StatefulWidget {
  final Future<void> Function() load;
  final Function()? whenComplete;
  final Function()? whenFail;

  const LoadView({required this.load, this.whenComplete, this.whenFail});

  @override
  _LoadViewState createState() => _LoadViewState();
}

class _LoadViewState extends State<LoadView> {
  late LoadStatus _status;
  late String _error;

  @override
  void initState() {
    super.initState();
    _status = LoadStatus.Loading;
    _error = 'Some error';
    init();
  }

  Future<void> init() async {
    try {
      await widget.load();
      setState(() {
        _status = LoadStatus.Complete;
      });
    } catch (e) {
      setState(() {
        _error = '$e';
        _status = LoadStatus.Fail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case LoadStatus.Loading:
        return _LoadingView();
      case LoadStatus.Fail:
        return _FailView(error: _error, whenFail: widget.whenFail);
      case LoadStatus.Complete:
        return _CompleteView(
          whenComplete: widget.whenComplete,
        );
      default:
        return _FailView(
          error: _error,
          whenFail: widget.whenFail,
        );
    }
  }
}

class _LoadingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: SpinKitThreeBounce(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CompleteView extends StatelessWidget {
  final Function()? whenComplete;

  const _CompleteView({required this.whenComplete});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  FontAwesomeIcons.checkCircle,
                  size: 70,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(10)),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'Everything is set.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          if (whenComplete == null) {
                            Navigator.pop(context);
                          } else {
                            whenComplete!();
                          }
                        },
                        child: Text('Return'))),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FailView extends StatelessWidget {
  final String error;
  final Function()? whenFail;

  const _FailView({required this.error, required this.whenFail});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Icon(
                  FontAwesomeIcons.exclamationCircle,
                  size: 70,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.all(10)),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    'Something went wrong.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(padding: const EdgeInsets.all(5)),
                  Text('Problem: some errors')
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          HapticFeedback.mediumImpact();
                          if (whenFail == null) {
                            Navigator.pop(context);
                          } else {
                            whenFail!();
                          }
                        },
                        child: Text('Return'))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
