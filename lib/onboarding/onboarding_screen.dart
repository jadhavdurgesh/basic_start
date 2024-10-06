import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart' as p;

import '../constants/colors.dart';
import '../constants/common/custom_button.dart';
import '../constants/common/custom_textfield.dart';
import '../experience/model/experience_model.dart';
import '../experience/utils/widgets/custom_line.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final AudioRecorder _audioRecorder = AudioRecorder();
  final AudioPlayer _audioPlayer = AudioPlayer();

  bool isRecording = false, isPlaying = false, isRecorded = false;
  String? recordFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_rounded,
              color: textColor,
            )),
        actions: [
          SizedBox(
            width: 280,
            height: 50,
            child: CustomPaint(
              size: const Size(double.infinity, 50),
              painter: SnakeLineHalfColorPainter(divider: 2),
            ),
          ),
          // 14.widthBox,
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.close_rounded,
                color: textColor,
              )),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const Spacer(),
            Text(
              "What kind of hotspots do you want to host?",
              style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  letterSpacing: 0.3),
            ),
            12.heightBox,
            const CustomTextfield(
              height: 365,
              lines: 15,
              length: 650,
            ),
            20.heightBox,
            isRecording
                ? Container(
                    height: 130,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(
                                0.1), // Darker side of the gradient
                            Colors.white.withOpacity(0.01), // More transparent
                            Colors.black.withOpacity(
                                0.1), // Darker side of the gradient
                            Colors.black.withOpacity(
                                0.1), // Darker side of the gradient
                            Colors.white.withOpacity(0.01), // More transparent
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Colors.blueGrey.withOpacity(0.3))),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isRecorded
                                    ? 'Audio Recorded'
                                    : 'Recording Audio...',
                                style: TextStyle(color: text2, fontSize: 16),
                              ),
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isRecording = false;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.delete_outline_rounded,
                                    color: primaryAccent,
                                    size: 20,
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                            children: [
                              IconButton.filled(
                                onPressed: () async {
                                  if (isRecording) {
                                    final String? filePath =
                                        await _audioRecorder.stop();
                                    if (filePath != null) {
                                      setState(() {
                                        isRecorded = true;
                                        recordFilePath = filePath;
                                      });
                                    }
                                  } else {
                                    print('not working bro');
                                  }
                                },
                                icon: Icon(
                                  Icons.mic,
                                  color: text2,
                                ),
                                color: primaryAccent,
                              ),
                              recordFilePath != null
                                  ? ElevatedButton(
                                      onPressed: () async {
                                        print(recordFilePath);
                                        if (_audioPlayer.playing) {
                                          _audioPlayer.stop();
                                          setState(() {
                                            isPlaying = false;
                                          });
                                        } else {
                                          await _audioPlayer
                                              .setFilePath(recordFilePath!);
                                          _audioPlayer.play();
                                          setState(() {
                                            isPlaying = true;
                                          });
                                        }
                                      },
                                      child: Text(isPlaying
                                          ? 'stop audio playing'
                                          : 'start audio playing'))
                                  : Container(
                                      child: Text('failed'),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            isRecording ? 20.heightBox : 0.heightBox,
            Row(
              children: [
                !isRecording
                    ? Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.black.withOpacity(
                                    0.1), // Darker side of the gradient
                                Colors.white
                                    .withOpacity(0.01), // More transparent
                                Colors.black.withOpacity(
                                    0.1), // Darker side of the gradient
                                Colors.black.withOpacity(
                                    0.1), // Darker side of the gradient
                                Colors.white
                                    .withOpacity(0.01), // More transparent
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.blueGrey.withOpacity(0.3))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                onPressed: () async {
                                  if (await _audioRecorder.hasPermission()) {
                                    final Directory appDocumentDir =
                                        await getApplicationDocumentsDirectory();

                                    final String filePath = p.join(
                                        appDocumentDir.path, "userRecording");
                                    await _audioRecorder.start(
                                        const RecordConfig(),
                                        path: filePath);
                                    setState(() {
                                      isRecording = true;
                                      recordFilePath = null;
                                    });
                                  }
                                },
                                icon: Icon(
                                  Icons.mic_rounded,
                                  color: text2,
                                )),
                            Container(
                              height: 20,
                              width: 1,
                              color: text2,
                            ),
                            IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.videocam_outlined,
                                  color: text2,
                                )),
                          ],
                        ),
                      )
                    : Column(),
                !isRecording ? 12.widthBox : 0.widthBox,
                Expanded(child: custom_button(ontap: (){},)),
              ],
            ),
            20.heightBox
          ],
        ),
      ),
    );
  }
}
