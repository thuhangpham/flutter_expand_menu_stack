// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'package:flutter/material.dart';

class ExpansionTileSample extends StatelessWidget {
  final lv1 = ListView.builder(
    itemBuilder: (BuildContext context, int index) =>
        EntryItem(dataDemo[index]),
    itemCount: dataDemo.length,
  );

  final lv2 = ListView.builder(
    itemBuilder: (BuildContext context, int index) =>
        EntryItem(dataDemo2[index]),
    itemCount: dataDemo2.length,
  );

  final lv3 = ListView.builder(
    itemBuilder: (BuildContext context, int index) =>
        EntryItem(dataDemo3[index]),
    itemCount: dataDemo3.length,
  );
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: const Text('ExpansionTile'),
            ),
            body:
//            new Column(
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[
                new Stack(
              children: <Widget>[
                // lv1,
                new Container(
                  margin: EdgeInsets.only(top: 0.0),
                  child: lv1,
                ),
                new Container(
                  margin: EdgeInsets.only(top: 50.0),
                  child: lv2,
                ),
                new Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: lv3,
                ),
              ],
            )
//              ],
//            )
            ));
  }
}

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> dataDemo = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry('Section A0'),
      Entry('Section A1'),
    ],
  )
];
final List<Entry> dataDemo2 = <Entry>[
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  )
];
final List<Entry> dataDemo3 = <Entry>[
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
    ],
  )
];
// The entire multilevel list displayed by this app.
final List<Entry> data = <Entry>[
  Entry(
    'Chapter A',
    <Entry>[
      Entry(
        'Section A0',
        <Entry>[
          Entry('Item A0.1'),
          Entry('Item A0.2'),
          Entry('Item A0.3'),
        ],
      ),
      Entry('Section A1'),
      Entry('Section A2'),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
//    return ExpansionTile(
////      backgroundColor: Colors.,
//      key: PageStorageKey<Entry>(root),
//      title: Text(root.title),
//      children: root.children.map(_buildChilds).toList(),
//    );
    return Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
              image: AssetImage("assets/images/img.png"),
              fit: BoxFit.fill,
            ),

//            color: const Color(0xB4C56C).withAlpha(255).withOpacity(1.0),
//            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border(
                bottom: BorderSide(color: Color(0xFFBDBDBD), width: 0.0))),
        child: ExpansionTile(
//          backgroundColor: Colors.blue,
          key: PageStorageKey<Entry>(root),
          title: Text(root.title),
          children: root.children.map(_buildChilds).toList(),
        ));
  }

  Widget _buildChilds(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return Container(
        decoration: BoxDecoration(
            image: new DecorationImage(
              image: AssetImage("assets/images/img.png"),
              fit: BoxFit.fill,
            ),

//            color: const Color(0xB4C56C).withAlpha(255).withOpacity(1.0),
//            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border(
                bottom: BorderSide(color: Color(0xFFBDBDBD), width: 0.0))),
        child: ExpansionTile(
//          backgroundColor: Colors.blue,
          key: PageStorageKey<Entry>(root),
          title: Text(root.title),
          children: root.children.map(_buildChilds).toList(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

void main() {
  runApp(ExpansionTileSample());
}
