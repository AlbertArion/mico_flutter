import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mico_flutter/content/JsonContent.dart';
import 'package:mico_flutter/content/PostItem.dart';
import 'package:mico_flutter/detail/DetailPage.dart';

class ListContent extends StatefulWidget {
  final String title;
  final List<Post> listData;

  ListContent({Key key, this.title, this.listData}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _ListPageState createState() => _ListPageState(listData);
}

class _ListPageState extends State<ListContent> {
  int selectedLineIndex = -1;
  List<Post> listData;

  var showDialog = false;

  _ListPageState(this.listData);

  void addLineAtLast() {}

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
      body: Stack(children: <Widget>[
        ListView.builder(
            itemBuilder: (context, index) {
              final listItem = listData[index];
              final heroTag = '飞过去$index';
              return new GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      new MaterialPageRoute(
                          builder: (context) =>
                              new DetailPage(listItem, heroTag)));
                },
                onLongPress: () {
                  showDialog = true;
                  selectedLineIndex = index;
                  setState(() {});
                },
                child: Hero(tag: heroTag, child: PostItem(post: listItem)),
              );
            },
            padding: const EdgeInsets.all(10),
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
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
