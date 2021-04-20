import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:memekar/View/sizeChanger.dart';

class TextDrag extends StatefulWidget {
  final String text;
  TextDrag({@required this.text});
  @override
  _TextDragState createState() => _TextDragState();
}

class _TextDragState extends State<TextDrag> {
  Offset offset = Offset.zero;
  double textSize = 30;
  Color textColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
            onTap: () async {
              var size = await showDialog(
                context: context,
                builder: (context) {
                  //on tap one can change the size of text

                  return SizeChanger(
                    whoseSize: widget.text,
                  );
                },
              );
              setState(() {
                textSize = size;
              });
              print(size);
              print("Size from ....");
            },
            onDoubleTap: () async {
              Color newColor;
              newColor = await showDialog(
                  context: context,
                  builder: (c) {
                    return Container(
                      child: AlertDialog(
                        title: Text(
                          "Pick Color",
                          textAlign: TextAlign.center,
                        ),
                        content: Container(
                          height: 220,
                          child: MaterialColorPicker(
                              allowShades: false,
                              onMainColorChange: (ColorSwatch color) {
                                Navigator.pop(context, color);
                              },
                              selectedColor: Colors.red),
                        ),
                      ),
                    );
                  });
              setState(() {
                textColor = newColor;
              });
            },
            onPanUpdate: (details) {
              setState(() {
                // to create displaceable behaviour I made use of positioned widget and on pan gesture detection I  update the offset values
                offset = Offset(
                    offset.dx + details.delta.dx, offset.dy + details.delta.dy);
              });
            },
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: textSize,
                  fontWeight: FontWeight.bold,
                  color: textColor),
            )),
      ),
    );
  }
}
