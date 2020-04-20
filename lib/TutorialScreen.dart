//This Screen will function as a video player for the application's tutorial video
//on how the game is played and how the application is used.

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class TutorialScreen extends StatefulWidget {
  @override
  _TutorialScreenState createState() => _TutorialScreenState();
}

class _TutorialScreenState extends State<TutorialScreen> {
  VideoPlayerController _controller;
  Future<void> _initialiseVideoPlayer;

  @override
  void initState() {
    _controller = VideoPlayerController.asset("assets/tutorialVideo.mp4");
    _initialiseVideoPlayer = _controller.initialize();
    _controller.setLooping(false);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[300],
      appBar: AppBar(
        title: Text('Tutorial', style: TextStyle(fontSize: 50)),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child:Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 600,
                  child: FutureBuilder(
                      future: _initialiseVideoPlayer,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          );
                        } else {
                          return Text(
                            "Loading Video",
                            style: TextStyle(color: Colors.deepPurple, fontSize: 70),
                          );
                        }
                      }),
                ),
              ],
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.yellow[300],
                        elevation: 14.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        height: 40,
                        minWidth: 80,
                        onPressed: () {
                          print("Play Button Pressed");
                          setState(() {
                            _controller.play();
                          });
                        },
                        child: Icon(Icons.play_arrow)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.yellow[300],
                        elevation: 14.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        height: 40,
                        minWidth: 80,
                        onPressed: () {
                          print("Pause Button Pressed");
                          setState(() {
                            _controller.pause();
                          });
                        },
                        child: Icon(Icons.pause)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                        color: Colors.yellow[300],
                        elevation: 14.0,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(20.0))),
                        height: 40,
                        minWidth: 80,
                        onPressed: () {
                          print("Restart Button Pressed");
                          setState(() {
                            _controller.initialize();
                          });
                        },
                        child: Icon(Icons.fast_rewind)),
                  ),
                ]),
          ],
        ),
      )
    );
  }
}
