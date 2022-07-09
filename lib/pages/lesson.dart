import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/providers/lessons_manager.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../utils/appColors.dart';

class LessonPage extends StatefulWidget {
  const LessonPage({
    Key? key,
    required this.fileNames,
    required this.appDirPath,
    required this.thumbnailPath,
    required this.isChecked,
  }) : super(key: key);
  final List<String> fileNames;
  final String appDirPath;
  final String thumbnailPath;
  final bool isChecked;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool isLoaded = false;
  VideoPlayerController? _controller;
  bool isSlowed = false;
  bool isMuted = true;
  bool isChecked = false;
  late String appDirPath;
  int videoSelected = 0;

  Widget roundedContainer(Widget icon, {double? width}) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryTextColor, width: width ?? 2.w),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(.5.w),
        child: icon,
      ),
    );
  }

  void checkFunction() async {
    var lessonManager = Provider.of<LessonsManager>(context, listen: false);
    if (isChecked) {
      lessonManager.addToLessonsCompleted(widget.thumbnailPath);
    } else {
      lessonManager.removeFromLessonsCompleted(widget.thumbnailPath);
    }
  }

  @override
  void initState() {
    if (isLoaded == false) {
      String fileName = widget.fileNames[0];
      String videoPath = "${widget.appDirPath}/$fileName";
      isChecked = widget.isChecked;
      _controller = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          _controller!.setLooping(true);
          _controller!.setVolume(0);
          _controller!.play();
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        });
      isLoaded = true;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 5.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isSlowed
                                          ? _controller!.setPlaybackSpeed(1)
                                          : _controller!.setPlaybackSpeed(0.5);
                                      isSlowed = isSlowed ? false : true;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Image.asset(
                                          "assets/icons/snail_icon.png"),
                                      if (isSlowed == false)
                                        Positioned.fill(
                                          child: Container(
                                            color:
                                                scaffoldColor.withOpacity(0.7),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 15.w),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      isMuted = !isMuted;
                                    });
                                    isMuted
                                        ? _controller!.setVolume(0)
                                        : _controller!.setVolume(1);
                                  },
                                  child: Icon(
                                    isMuted
                                        ? Icons.volume_off
                                        : Icons.volume_up,
                                    size: 40.w,
                                    color: primaryTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 10.w),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).pop(),
                                  child: Icon(
                                    Icons.west,
                                    size: 35.w,
                                    color: primaryTextColor,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.w),
                                child: InkWell(
                                  onTap: () => setState(() {
                                    isChecked = !isChecked;
                                    checkFunction();
                                  }),
                                  child: Icon(
                                    isChecked
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                    size: 35.w,
                                    color: primaryTextColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Center(
                      child: _controller!.value.isInitialized
                          ? AspectRatio(
                              aspectRatio: _controller!.value.aspectRatio,
                              child: VideoPlayer(_controller!),
                            )
                          : Container(),
                    ),
                    SizedBox(height: 20.h),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        7,
                        (index) {
                          int innerIndex = index + 1;
                          return InkWell(
                            onTap: () {
                              String newFilePath =
                                  "${widget.appDirPath}/${widget.fileNames[index]}";
                              print(newFilePath);
                              var newFile = File(newFilePath);
                              _controller!.dispose();
                              _controller = VideoPlayerController.file(newFile)
                                ..initialize().then((_) {
                                  _controller!.setLooping(true);
                                  if (isSlowed) {
                                    _controller!.setPlaybackSpeed(0.5);
                                  }
                                  if (isMuted) {
                                    _controller!.setVolume(0);
                                  }
                                  _controller!.play();
                                  setState(() {
                                    videoSelected = index;
                                  });
                                });
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 10.w),
                              child: roundedContainer(
                                  Padding(
                                    padding: EdgeInsets.all(20.w),
                                    child: Text(
                                      innerIndex.toString(),
                                      style: TextStyle(
                                        fontSize: 22.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  width: videoSelected == index ? 4.w : null),
                            ),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _controller!.value.isPlaying
                      ? _controller!.pause()
                      : _controller!.play();
                });
              },
              child: Icon(
                _controller!.value.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          )
        : const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
  }
}
