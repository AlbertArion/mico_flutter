import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  String title;
  String data;
  String heroTag;
  Color color;

  DetailPage(this.title, this.data, this.heroTag, this.color);

  @override
  State<StatefulWidget> createState() => _DetailPageState(data);
}

class _DetailPageState extends State<DetailPage> {
  String data;

  _DetailPageState(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: new Center(
                child: new Hero(
                    tag: widget.heroTag,
                    child: Text(data.replaceAll('行', '页'),
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: widget.color))))));
  }
}
