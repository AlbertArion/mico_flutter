import 'package:flutter/material.dart';
import 'package:mico_flutter/content/JsonContent.dart';
import 'package:mico_flutter/content/PostItem.dart';

class DetailPage extends StatefulWidget {
  final Post post;
  final String heroTag;

  DetailPage(this.post, this.heroTag);

  @override
  State<StatefulWidget> createState() => _DetailPageState(post);
}

class _DetailPageState extends State<DetailPage> {
  Post data;

  _DetailPageState(this.data);

  String getTitle() {
    return widget.post.hasTitle() ? widget.post.title : "详情页";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          actions: <Widget>[
            Container(
                margin: EdgeInsets.all(10),
                child: Icon(Icons.more_horiz, size: 18, color: Colors.white))
          ],
        ),
        body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Center(
                child: new Hero(
                    tag: widget.heroTag, child: PostItem(post: data)))));
  }
}
