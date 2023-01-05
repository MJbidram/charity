import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() => runApp(MaterialApp(title: "Wifi Check", home: MyPage()));

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool _tryAgain = false;

  @override
  void initState() {
    super.initState();
    _checkWifi();
  }

  _checkWifi() async {
    // the method below returns a Future
    var connectivityResult = await (new Connectivity().checkConnectivity());
    bool connectedToWifi = (connectivityResult == ConnectivityResult.wifi);
    if (!connectedToWifi) {
      _showAlert(context);
    }
    if (_tryAgain != !connectedToWifi) {
      setState(() => _tryAgain = !connectedToWifi);
    }
  }

  @override
  Widget build(BuildContext context) {
    var body = Container(
      alignment: Alignment.center,
      child: _tryAgain
          ? TextButton(
              child: Text("Try again"),
              onPressed: () {
                _checkWifi();
              })
          : Text("This device is connected to Wifi"),
    );

    return Scaffold(appBar: AppBar(title: Text("Wifi check")), body: body);
  }

  void _showAlert(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Wifi"),
              content: Text("Wifi not detected. Please activate it."),
            ));
  }
}
