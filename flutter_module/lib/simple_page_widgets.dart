import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boost/flutter_boost.dart';

class FirstRouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Route'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: RaisedButton(
              child: Text('Open second route'),
              onPressed: () {
                print("open second page!");
                FlutterBoost.singleton
                    .open("second", exts: {"animated": true}).then((Map value) {
                  print(
                      "call me when page is finished. did recieve second route result $value");
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50),
            child: RaisedButton(
              child: Text('Go back with result'),
              onPressed: () {
                BoostContainerSettings settings =
                    BoostContainer.of(context).settings;
                FlutterBoost.singleton.close(settings.uniqueId,
                    result: {"result": "data from first"});
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SecondRouteWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            child: Text('push native page'),
            onPressed: () {
              FlutterBoost.singleton.open("native_push_NativeViewController",
                  urlParams: {"query": "aaa"}, exts: {"animated": true});
            },
          ),
          RaisedButton(
            child: Text('Go back with result'),
            onPressed: () {
              BoostContainerSettings settings =
                  BoostContainer.of(context).settings;
              FlutterBoost.singleton.close(settings.uniqueId,
                  result: {"result": "data from second"});
            },
          ),
        ],
      ),
    );
  }
}

class FlutterRouteWidget extends StatefulWidget {
  FlutterRouteWidget({this.params, this.message});
  final Map params;
  final String message;

  @override
  _FlutterRouteWidgetState createState() => _FlutterRouteWidgetState();
}

class _FlutterRouteWidgetState extends State<FlutterRouteWidget> {

  @override
  Widget build(BuildContext context) {
    final String message = widget.message;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        textTheme: new TextTheme(title: TextStyle(color: Colors.black)),
        title: Text('flutter_home'),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                child: Text(
                  message ??
                      "This is a flutter activity \n params:${widget.params}",
                  style: TextStyle(fontSize: 28.0, color: Colors.blue),
                ),
                alignment: AlignmentDirectional.center,
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.yellow,
                    child: Text(
                      'push native page',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
                onTap: () => FlutterBoost.singleton.open(
                    "native_push_NativeViewController",
                    urlParams: {"query": "aaa"},
                    exts: {"animated": true}),
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.yellow,
                    child: Text(
                      'present native page',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
                onTap: () => FlutterBoost.singleton.open(
                    "native_present_NativeViewController",
                    urlParams: {"query": "bbb"},
                    exts: {"animated": true}),
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.yellow,
                    child: Text(
                      'push first flutter use native',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
                onTap: () => FlutterBoost.singleton.open("first",
                    urlParams: {"query": "aaa"}, exts: {"animated": true}),
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.yellow,
                    child: Text(
                      'push first flutter use flutter',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => FirstRouteWidget()));
                },
              ),
              InkWell(
                child: Container(
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.all(8.0),
                    color: Colors.yellow,
                    child: Text(
                      'go back',
                      style: TextStyle(fontSize: 22.0, color: Colors.black),
                    )),
                onTap: () {
                  FlutterBoost.singleton.closeCurrent();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}