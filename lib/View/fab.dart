import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FAB extends StatelessWidget {
  final onText;
  final onEmoji;
  FAB({this.onText, this.onEmoji});
  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      marginEnd: 18,
      marginBottom: 20,
      icon: Icons.add,
      activeIcon: Icons.remove,
      buttonSize: 56.0,
      visible: true,
      closeManually: false,
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: Colors.amber,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      children: [
        SpeedDialChild(
            child: Icon(
              Icons.text_fields,
              color: Colors.white,
            ),
            backgroundColor: Colors.amber,
            label: 'Text',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            onTap: () => onText(context),
            onLongPress: () => print('FIRST CHILD LONG PRESS'),
            labelBackgroundColor: Colors.orange),
        SpeedDialChild(
            child: Icon(
              Icons.emoji_emotions,
              color: Colors.white,
            ),
            backgroundColor: Colors.amber,
            label: 'Emoji',
            labelStyle: TextStyle(fontSize: 18.0, color: Colors.white),
            onTap: () => onEmoji(context),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
            labelBackgroundColor: Colors.orange),
      ],
    );
  }
}
