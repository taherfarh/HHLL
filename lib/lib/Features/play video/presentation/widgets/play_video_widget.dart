import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:no_screenshot/no_screenshot.dart';


class VideoPlayerPage extends StatefulWidget {
  final String videoname;
  final String coursname;

  const VideoPlayerPage({Key? key, required this.coursname,required this.videoname}) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
   final noscreenshot=NoScreenshot.instance;
 late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
 // double _playbackSpeed = 1.0;

  @override
  void initState() {
    noscreenshot.screenshotOff();
    super.initState();
    _videoPlayerController = VideoPlayerController.network("https://aliceblue-dolphin-854247.hostingersite.com/mo/${widget.coursname}/${widget.videoname}.mp4");
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  // void _changePlaybackSpeed(double speed) {
  //   setState(() {
  //     _playbackSpeed = speed;
  //     _videoPlayerController.setPlaybackSpeed(_playbackSpeed);
  //   });
  // }

  // void _toggleFullscreen() {
  //   // Implement fullscreen toggle logic
  //   // This can be done using a package like 'flutter_fullscreen'
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: Column(
        children: [
          Expanded(
            child: Chewie(
              controller: _chewieController,
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Text('Speed: '),
          //     DropdownButton<double>(
          //       value: _playbackSpeed,
          //       items: [
          //         DropdownMenuItem(value: 0.5, child: Text('0.5x')),
          //         DropdownMenuItem(value: 1.0, child: Text('1.0x')),
          //         DropdownMenuItem(value: 1.5, child: Text('1.5x')),
          //         DropdownMenuItem(value: 2.0, child: Text('2.0x')),
          //       ],
          //       onChanged: (value) {
          //         if (value != null) {
          //           _changePlaybackSpeed(value);
          //         }
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}