import 'package:flutter/material.dart';
import 'package:memekar/View/sizeChanger.dart';

class EmojiDrag extends StatefulWidget {
  final emoji;
  EmojiDrag({@required this.emoji});
  @override
  _EmojiDragState createState() => _EmojiDragState();
}

class _EmojiDragState extends State<EmojiDrag> {
  Offset offset = Offset.zero;
  double emojiSize = 30;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Positioned(
        left: offset.dx,
        top: offset.dy,
        child: GestureDetector(
            onTap: () async {
              //on tap one can change the size of emoji
              var size = await showDialog(
                  context: context,
                  builder: (c) => SizeChanger(
                        whoseSize: widget.emoji,
                      ));
              setState(() {
                emojiSize = size;
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
              widget.emoji,
              style: TextStyle(
                  fontSize: emojiSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )),
      ),
    );
  }
}
