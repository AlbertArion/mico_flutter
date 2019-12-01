import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mico_flutter/content/JsonContent.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({Key key, @required this.post}) : super(key: key);

  bool isPostType() {
    return post != null && post.hasAuthor();
  }

  Widget createItemAvatar() {
    if (post.author.hasIcon()) {
      return Image.network(post.author.icon, width: 42.0, height: 42.0);
    } else {
      return Icon(Icons.account_circle, size: 42, color: Colors.black26);
    }
  }

  Widget createItemHeader() {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 13.0, right: 13.0),
              child: createItemAvatar(),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(post.author.name,
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                      maxLines: 1),
                  Padding(padding: const EdgeInsets.only(top: 8.0)),
                  Text('来自' + post.deviceType,
                      style: TextStyle(fontSize: 9, color: Colors.black38),
                      maxLines: 1)
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 12, top: 12),
              child: Icon(Icons.more_horiz, size: 18, color: Colors.black26),
            )
          ],
        ));
  }

  Widget createItemTitle() {
    return Container(
        margin: EdgeInsets.all(10),
        child: Text(
          post.title,
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 17,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ));
  }

  Widget createItemImage(url) {
    return Container(child: Image.network(url), padding: EdgeInsets.all(10));
  }

  Widget createItemFooter() {
    return Container(
        child: Row(
          children: <Widget>[
            Expanded(
                child: Text('${post.viewCount} 浏览',
                    style: TextStyle(fontSize: 13, color: Colors.black54))),
            Container(
              child: Row(children: <Widget>[
                Icon(
                  Icons.comment,
                  color: Colors.black26,
                  size: 20,
                ),
                Padding(padding: EdgeInsets.only(left: 4)),
                Text('${post.commentCnt}',
                    style: TextStyle(fontSize: 13, color: Colors.black54)),
              ]),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.only(left: 10, right: 10),
            ),
            Container(
                child: Row(children: <Widget>[
                  Icon(
                    Icons.favorite,
                    color: Colors.black26,
                    size: 20,
                  ),
                  Padding(padding: EdgeInsets.only(left: 4)),
                  Text('${post.likeCnt}',
                      style: TextStyle(fontSize: 13, color: Colors.black54)),
                ]),
                alignment: Alignment.centerRight),
          ],
        ),
        margin: EdgeInsets.all(13));
  }

  Widget createPostItem() {
    var widgetArray = <Widget>[];
    widgetArray.add(createItemHeader());
    if (post.hasTitle()) {
      widgetArray.add(createItemTitle());
    }
    widgetArray.add(createItemImage(post.pic));
    widgetArray.add(createItemFooter());
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetArray);
  }

  Widget createItem(BuildContext context) {
    if (isPostType()) {
      return createPostItem();
    } else {
      return createBannerItem();
    }
  }

  Widget createBannerItem() {
    var widgetArray = <Widget>[];
    if (post.hasTitle()) {
      widgetArray.add(createItemTitle());
    }
    for (Detail detail in post.detailList) {
      if (detail.hasImg()) {
        widgetArray.add(createItemImage(detail.img));
      }
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widgetArray);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(width: 0.5, color: Colors.transparent))),
      margin: EdgeInsets.only(bottom: 10),
      child: createItem(context),
    );
  }
}
