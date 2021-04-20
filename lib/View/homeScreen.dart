import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:emoji_picker/emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:memekar/View/drawerView.dart';
import 'package:memekar/View/emojiDrag.dart';
import 'package:memekar/View/fab.dart';
import 'package:memekar/View/textDrag.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

TextEditingController _textEditingController = TextEditingController();
GlobalKey globalRepaintBoundaryKey = GlobalKey();

class _HomeScreenState extends State<HomeScreen> {
  File _image;
  final picker = ImagePicker();
  List<String> text = [];
  double emojiSize = 10;
  double textSize = 10;
  //get image using image picker
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widList.add(Image.file(
          _image,
          fit: BoxFit.contain,
        ));
      } else {
        print('No image selected.');
      }
    });
  }

//dialog to enter text on image
//Created a displaceable widget called as TextDrag
  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter the text'),
            content: TextField(
              onChanged: (value) {},
              controller: _textEditingController,
              decoration: InputDecoration(hintText: "Enter text here..."),
              onSubmitted: (value) {
                _textEditingController.clear();
                Navigator.pop(context);
                print(value);
                setState(() {
                  // selected text is added to widlist which is added on stack further
                  widList.add(TextDrag(text: value));
                });
              },
            ),
          );
        });
  }

//bottom sheet which contains the emoji selector
//Emoji picker is used to select an emoji
//Created a displaceable widget out of emoji called as EmojiDrag
  _displayEmojiSelector(BuildContext context) {
    return showModalBottomSheet<void>(
        context: context,
        backgroundColor: Colors.black12,
        builder: (BuildContext context) {
          return Container(
              decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Select Emoji",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  EmojiPicker(onEmojiSelected: (emoji, c) {
                    // selected emoji is added to widlist which is added on stack further
                    setState(() {
                      widList.add(EmojiDrag(emoji: emoji.emoji));
                    });
                    Navigator.pop(context);
                  }),
                ],
              ));
        });
  }

//taking screenshot of all the widgets in repaint boundary
  takeScreenshot() async {
    RenderRepaintBoundary boundary =
        globalRepaintBoundaryKey.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage(pixelRatio: 3);
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    _savefile(byteData);
  }

//  the byte data created by  Render repaint boundary is then saved to gallery using ImageGallery saver
  _savefile(ByteData byteData) async {
    print('Save file called');
    await _askPermission();
    final result = await ImageGallerySaver.saveImage(
        byteData.buffer.asUint8List(),
        quality: 100);
    print(result['filePath']);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Yay! Meme saved!')));
  }

//Permission handler is used to handle the permissions at runtime
  _askPermission() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.storage,
    ].request();
    if (statuses[1].isDenied) {
      print("Permission for photos storage is denied");
    }
    print("Permission:" + statuses.toString());
  }

//widlist contains all the emojis and text to be  added on the image
  List<Widget> widList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerView(),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'MemeKar',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.save, color: Colors.white),
            onPressed: _image != null
                ? () {
                    takeScreenshot();
                    setState(() {
                      _image = null;
                    });
                  }
                : null,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.all(10),
                height: 600,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.grey,
                ),
                child: Center(
                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.add_a_photo_rounded,
                                color: Colors.white,
                                size: 30,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                            Text(
                              "Please select an image.",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          ],
                        )
                      // if image is selected then all the text and emojis in the widlist are rendered
                      : RepaintBoundary(
                          key: globalRepaintBoundaryKey,
                          child: Stack(
                              fit: StackFit.passthrough,
                              alignment: Alignment.center,
                              children: widList),
                        ),
                ),
              ),
            ),
            _image != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Tap to change the size of text or emoji.\nDouble tap to change color of text.",
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  )
                : Container()
          ],
        ),
      ),
      floatingActionButton: _image != null
          ? FAB(
              onText: _displayTextInputDialog,
              onEmoji: _displayEmojiSelector,
            )
          : null,
    );
  }
}
