# bridges_load
## Installation
1. Add this lines to pubspec.yaml
```yaml
bridges_load:
  git:
    url: https://github.com/bridges2021/bridges_load.git
    ref: main
```
## How to use
1. Call load() / Navigator to LoadView()
```dart
load(context, load: () async {await Future.delay(Duration(seconds: 1)});
Navigator.push(context, LoadView(load: () async {await Future.delay(Duration(seconds: 1});
```
