import 'dart:math';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  final List<String> listData;

  MyHomePage({Key key, this.title, this.listData}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState(listData);
}

class _MyHomePageState extends State<MyHomePage> {
  final textColor = [
    Colors.black87,
    Colors.green,
    Colors.red[300],
    Colors.lightBlue
  ];
  int selectedLineIndex = -1;
  List<String> listData;

  var showDialog = false;

  _MyHomePageState(this.listData);

  void addLineAtLast() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      final currentLineCount = listData.length + 1;
      listData.add('这是第$currentLineCount行');
    });
  }

  void removeSelectedLine() {
    if (selectedLineIndex >= 0) {
      listData.removeAt(selectedLineIndex);
      cancelSelection();
    }
  }

  getSize() {
    return listData.length;
  }

  void cancelSelection() {
    selectedLineIndex = -1;
    showDialog = false;
    setState(() {});
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

      body: Stack(children: <Widget>[
        ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                  title: Text(
                    listData[index],
                    style: new TextStyle(
                        height: 2.2,
                        wordSpacing: 10,
                        fontSize: 18,
                        color: textColor[Random.secure().nextInt(4)]),
                  ),
                  onLongPress: () {
                    showDialog = true;
                    selectedLineIndex = index;
                    setState(() {});
                  });
            },
            padding: const EdgeInsets.all(40),
            itemCount: getSize()),
        Offstage(
            offstage: !showDialog,
            child: AlertDialog(
                title: Text('提示'),
                content: Text("确认删除此行？"),
                actions: <Widget>[
                  FlatButton(
                      child: Text('确定'),
                      onPressed: () {
                        removeSelectedLine();
                      }),
                  FlatButton(
                      child: Text('取消'),
                      onPressed: () {
                        cancelSelection();
                      })
                ]))
      ]),

      floatingActionButton: FloatingActionButton(
        onPressed: addLineAtLast,
        tooltip: '增加一行',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
