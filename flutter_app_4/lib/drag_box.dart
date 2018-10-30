import 'package:flutter/material.dart';

class DragBox extends StatefulWidget {
  final Offset startPosition;
  final Color color;
  final String label;
  final Function bringToTop;
  final Key key;

  DragBox(
      {this.key,
      this.startPosition,
      this.color: const Color.fromRGBO(255, 255, 255, 1.0),
      this.label,
      this.bringToTop});

  @override
  DragBoxState createState() => DragBoxState();
}

class DragBoxState extends State<DragBox> {
  Offset position;
  Offset _startPos;

  @override
  void initState() {
    position = widget.startPosition;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 4.0,
        top: 1.0,
//        left: position.dx.abs(),
//        top: position.dy.abs(),
        child: GestureDetector(
            onScaleStart: (details) {
              //Store start conditions
              _startPos = details.focalPoint;

              widget.bringToTop(widget);
            },
            onScaleUpdate: (scaleDetails) {
              setState(() {
                position += scaleDetails.focalPoint - _startPos;
                _startPos = scaleDetails.focalPoint;
              });
            },
            child: _buildPart()));
  }

  Widget _buildPart() {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0), width: 1.0),
          color: widget.color),
      child: Text(
        'text',
        style: TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1.0),
          //decoration: TextDecoration.none,
          fontSize: 15.0,
        ),
      ),
    );
  }
}

class WorkTable extends StatefulWidget {
  @override
  WorkTableState createState() => WorkTableState();
}

class WorkTableState extends State<WorkTable> {
  List<DragBox> dragParts = [];

  @override
  void initState() {
    dragParts = [];

    //dragParts = [];
    dragParts.add(DragBox(
      key: GlobalKey(),
      startPosition: Offset(0.0, 0.0),
      color: Colors.red,
      label: "Box1",
      bringToTop: this.bringToTop,
    ));

    dragParts.add(DragBox(
      key: GlobalKey(),
      startPosition: Offset(50.0, 50.0),
      color: Colors.red,
      label: "Box2",
      bringToTop: this.bringToTop,
    ));

    dragParts.add(DragBox(
      key: GlobalKey(),
      startPosition: Offset(100.0, 100.0),
      color: Colors.blue,
      label: "Box3",
      bringToTop: this.bringToTop,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    for (DragBox d in dragParts) {
      print(d.label);
    }
    return Stack(
      children: dragParts,
    );
  }

  void bringToTop(Widget widget) {
    setState(() {
      dragParts.remove(widget);
      dragParts.add(widget);
    });
  }
}
