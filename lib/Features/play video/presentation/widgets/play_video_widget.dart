import 'dart:convert';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:http/http.dart' as http;

class VideoPlayerPage extends StatefulWidget {
  final String videolink;
  final String coursname;

  const VideoPlayerPage({
    Key? key,
    required this.coursname,
    required this.videolink,
  }) : super(key: key);

  @override
  _VideoPlayerPageState createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  final noscreenshot = NoScreenshot.instance;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;

  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    noscreenshot.screenshotOff();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      final url =
          'https://aliceblue-dolphin-854247.hostingersite.com/mo/GetVideoLink.php?course=${Uri.encodeComponent(widget.coursname)}&video=${Uri.encodeComponent(widget.videolink)}';

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200 && response.body.isNotEmpty) {
        final videoUrl = response.body.trim();

        _videoPlayerController = VideoPlayerController.network(videoUrl);
        await _videoPlayerController!.initialize();

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController!,
          autoPlay: true,
          looping: true,
        );

        setState(() => isLoading = false);
      } else {
        setState(() {
          error = "فشل في تحميل الفيديو";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        error = "حدث خطأ أثناء جلب الرابط: $e";
        print(error);
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(child: Text(error!)),
      );
    }

    return Scaffold(
      body: Chewie(
        controller: _chewieController!,
      ),
    );
  }
}
