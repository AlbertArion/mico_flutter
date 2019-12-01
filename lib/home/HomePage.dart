import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mico_flutter/content/JsonContent.dart';
import 'package:mico_flutter/content/ListContent.dart';

class MyHomePage extends StatefulWidget {
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _MyHomePageState createState() => _MyHomePageState(0);
}

class _MyHomePageState extends State<MyHomePage> {
  int currentPage;

  _MyHomePageState(this.currentPage);

  Widget _getCurrentContent() {
    Widget widget = Center(
        child: Text(_getCurrentTitle(),
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 30,
                fontWeight: FontWeight.bold)));
    switch (currentPage) {
      case 0:
        widget = ListContent(
          title: getTitleByIndex(currentPage),
          listData: DataParser.getFirstPagePosts(),
        );
        break;
    }
    return widget;
  }

  String getTitleByIndex(index) {
    String result;
    switch (index) {
      case 0:
        result = "广场";
        break;
      case 1:
        result = "圈子";
        break;
      case 2:
        result = "发布";
        break;
      case 3:
        result = "福利";
        break;
      case 4:
        result = "我的";
        break;
    }
    return result;
  }

  String _getCurrentTitle() {
    return getTitleByIndex(currentPage);
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
        title: Text(_getCurrentTitle()),
        centerTitle: true,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.black,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), title: const Text('广场')),
          BottomNavigationBarItem(icon: Icon(Icons.apps), title: Text('圈子')),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_see), title: Text('发布')),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), title: Text('福利')),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text('我的'))
        ],
        currentIndex: currentPage,
        onTap: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      body: _getCurrentContent(),
    );
  }
}
