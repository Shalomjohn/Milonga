import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:video_player/video_player.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late VideoPlayerController _controller;
  bool isPlaying = false;
  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/test_video.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            Stack(
              children: [
                InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 20.w),
                    child: Icon(
                      Icons.west,
                      size: 30.w,
                      color: primaryTextColor,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 35.h,
                  child: FittedBox(
                    fit: BoxFit.fill,
                    child: Image.asset('assets/icons/milonga_text.png'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'INFO',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: primaryTextColor,
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20.w),
                  child: Icon(
                    Icons.east,
                    size: 30.w,
                    color: primaryTextColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 50.h),
            _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(height: 300.h),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    print(_controller.value.aspectRatio);
                    setState(() {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    });
                  },
                  child: roundedContainer(
                    Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: primaryTextColor,
                      size: 50.w,
                    ),
                  ),
                ),
                roundedContainer(
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: primaryTextColor,
                      size: 35.w,
                    ),
                  ),
                ),
                roundedContainer(
                  Padding(
                    padding: EdgeInsets.all(8.w),
                    child: Icon(
                      Icons.share,
                      color: primaryTextColor,
                      size: 35.w,
                    ),
                  ),
                ),
                Icon(
                  Icons.copyright,
                  color: primaryTextColor,
                  size: 65.w,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
