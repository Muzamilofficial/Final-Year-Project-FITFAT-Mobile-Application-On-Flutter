import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isloop;
  bool isFinished = false;
  VideoPlayer({required this.isloop, required this.videoPlayerController});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late ChewieController chewieController;
  
  @override
  void initState() {
    chewieController = ChewieController(
      
        //looping: widget.isloop,
        aspectRatio: 16 / 9,
        allowMuting: true,
        autoPlay: true,
        //fullScreenByDefault: true,
        autoInitialize: true,
        videoPlayerController: widget.videoPlayerController);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    chewieController.dispose();
    chewieController.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: chewieController,
      ),
    );
  }
}

class ReverseLunge extends StatefulWidget {
  ReverseLunge();

  @override
  _VideoDisplayState createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<ReverseLunge> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: BackButton(
            onPressed: () {
              dispose();
              
              Navigator.popAndPushNamed(context, '/ConsultantConsulting');
              // Navigator.of(context)
              //     .push(MaterialPageRoute(builder: (context) => YOGA()));
            },
            color: Colors.white, // <-- SEE HERE
          ),
          centerTitle: true,
        ),
        body: VideoPlayer(
          isloop: false,
          videoPlayerController: VideoPlayerController.network(
              'https://www.youtube.com/watch?v=qeJ3Si5r5y0'),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
