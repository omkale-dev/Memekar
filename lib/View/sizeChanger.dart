import 'package:flutter/material.dart';

class SizeChanger extends StatefulWidget {
  final String whoseSize;
  SizeChanger({this.whoseSize});
  @override
  _SizeChangerState createState() => _SizeChangerState();
}

class _SizeChangerState extends State<SizeChanger> {
  double textSize = 30;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Change size',
        textAlign: TextAlign.center,
      ),
      content: Container(
        height: 300,
        // width: 400,
        child: Column(
          children: [
            Center(
              child: Text(
                widget.whoseSize,
                style: TextStyle(
                  fontSize: textSize,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Spacer(),
            Slider(
              min: 10,
              max: 100,
              value: textSize,
              onChanged: (value) {
                setState(() {
                  textSize = value;
                });
              },
            ),
            ElevatedButton(
                onPressed: () {
                  // the size is given back
                  Navigator.pop(context, textSize);
                },
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
