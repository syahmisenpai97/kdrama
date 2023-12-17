import 'dart:async';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class Player extends StatefulWidget {
  final String ep, url, media;

  const Player(
      {Key? key, required this.ep, required this.url, required this.media})
      : super(key: key);

  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  late bool showChewie;

  @override
  void initState() {
    super.initState();
    showChewie = false;
    Map<String, String> headers = {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36',
    };
    _videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(widget.media),
      httpHeaders: headers,
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 16 / 9, // Adjust as needed
      autoPlay: true,
      looping: true,
      // Other customization options can be added here
    );
    // Start the countdown and show Chewie after 5 seconds
    Timer(Duration(seconds: 5), () {
      setState(() {
        showChewie = true;
      });
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Running Man"),
        actions: const [],
      ),
      body: Stack(
        children: [
          if (!showChewie)
            Center(
              child: Countdown(
                duration: Duration(seconds: 5),
                onFinish: () {
                  setState(() {
                    showChewie = true;
                  });
                },
              ),
            ),
          if (showChewie)
            Chewie(
              controller: _chewieController,
            ),
        ],
      ),
    );
  }
}

class Countdown extends StatefulWidget {
  final Duration duration;
  final VoidCallback onFinish;

  Countdown({required this.duration, required this.onFinish});

  @override
  _CountdownState createState() => _CountdownState();
}

class _CountdownState extends State<Countdown> {
  late int _seconds;

  @override
  void initState() {
    super.initState();
    _seconds = widget.duration.inSeconds;
    startTimer();
  }

  void startTimer() {
    Timer.periodic(Duration(seconds: 1), (Timer timer) {
      if (_seconds == 0) {
        timer.cancel();
        widget.onFinish();
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '$_seconds',
      style: TextStyle(fontSize: 48),
    );
  }
}
