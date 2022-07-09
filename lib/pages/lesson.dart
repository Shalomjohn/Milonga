import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../utils/appColors.dart';

class LessonPage extends StatefulWidget {
  const LessonPage(
      {Key? key, required this.fileNames, required this.appDirPath})
      : super(key: key);
  final List<String> fileNames;
  final String appDirPath;

  @override
  State<LessonPage> createState() => _LessonPageState();
}

class _LessonPageState extends State<LessonPage> {
  bool isLoaded = false;
  VideoPlayerController? _controller;
  bool isSlowed = false;
  bool isMuted = false;
  bool isChecked = false;
  late String appDirPath;

  Widget roundedContainer(Widget icon) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: primaryTextColor, width: 2.w),
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: EdgeInsets.all(.5.w),
        child: icon,
      ),
    );
  }

  @override
  void initState() {
    if (isLoaded == false) {
      String fileName = widget.fileNames[0];
      String videoPath = "${widget.appDirPath}/$fileName";
      _controller = VideoPlayerController.file(File(videoPath))
        ..initialize().then((_) {
          _controller!.setLooping(true);
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
              child: Column(
                children: [
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
                                child:
                                    Image.asset("assets/icons/snail_icon.png"),
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
                                  isMuted ? Icons.volume_up : Icons.volume_off,
                                  size: 40.w,
                                  color: primaryTextColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 20.w),
                            child: InkWell(
                              onTap: () => Navigator.of(context).pop(),
                              child: Icon(
                                Icons.west,
                                size: 30.w,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: InkWell(
                              onTap: () => setState(() {
                                isChecked = !isChecked;
                              }),
                              child: Icon(
                                isChecked
                                    ? Icons.check_box
                                    : Icons.check_box_outline_blank,
                                color: primaryTextColor,
                              ),
                            ),
                          ),
                        ],
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
                          // onTap: () => setState(() {
                          //   _controller = VideoPlayerController.file(File(
                          //       "${widget.appDirPath}/${widget.fileNames[index]}"));
                          // }),
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
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
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