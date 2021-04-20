import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          "About",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage(
                  'assets/images/Om.jpeg',
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Hey!, My name is Om Kale.\nI love Memes.\nI build MemeKar app to learn to handle image files\'s.\nI made use of various packages.\nI learned to create a draggable widget, take widget snapshots, and store them to internal storage.\nI got to learn a lot while making this app.',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
              ),
            ),
            Image.asset('assets/images/aboutMe.png'),
          ],
        ),
      ),
    );
  }
}
