import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';

class VideoRecordingScreen extends StatefulWidget {
  @override
  _VideoRecordingScreenState createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool isRecording = false;
  String? videoPath; // This is correctly defined as nullable
  VideoPlayerController? _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    _controller = CameraController(
      cameras.first,
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<void> _startRecording() async {
    if (!_controller.value.isRecordingVideo) {
      final directory = await getApplicationDocumentsDirectory();
      videoPath = p.join(directory.path, '${DateTime.now()}.mp4');

      // Start recording with optional onAvailable callback
      await _controller.startVideoRecording(onAvailable: (CameraImage image) {
        // Process the camera image if needed
        // For example, you could add real-time image processing here.
      });

      setState(() {
        isRecording = true;
      });
    }
  }

  Future<void> _stopRecording() async {
    if (_controller.value.isRecordingVideo) {
      XFile videoFile =
          await _controller.stopVideoRecording(); // Get the recorded video file
      setState(() {
        isRecording = false;
        videoPath = videoFile.path; // Save the path of the recorded video
        // Initialize video player controller with the correct file
        _videoPlayerController = VideoPlayerController.file(File(videoPath!));
        _videoPlayerController!.initialize().then((_) {
          setState(() {});
        });
      });
    }
  }

  void _deleteVideo() {
    if (videoPath != null) {
      File(videoPath!).deleteSync(); // Use deleteSync to remove immediately
      setState(() {
        videoPath = null;
        _videoPlayerController?.dispose();
        _videoPlayerController = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Recording'),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: _deleteVideo,
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Column(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CameraPreview(_controller),
                ),
                if (videoPath != null) ...[
                  // Preview box for recorded video
                  Container(
                    height: 200,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: _videoPlayerController != null
                              ? VideoPlayer(_videoPlayerController!)
                              : Center(child: Text('No Video')),
                        ),
                        Text("Video Recorded"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              icon: Icon(Icons.play_arrow),
                              onPressed: () {
                                _videoPlayerController?.play();
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.pause),
                              onPressed: () {
                                _videoPlayerController?.pause();
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Icon(isRecording ? Icons.stop : Icons.circle),
                      color: isRecording ? Colors.red : Colors.blue,
                      onPressed: isRecording ? _stopRecording : _startRecording,
                    ),
                  ],
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
