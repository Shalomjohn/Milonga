import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:milonga/pages/menu.dart';
import 'package:milonga/utils/appColors.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  late VideoPlayerController _controller;
  bool isMuted = true;
  bool showingPlayButton = false;
  bool subscriptionIsMonthly = true;

  void onPortraitScreenTouch({bool long = false}) {
    if (showingPlayButton) {
      setState(() {
        showingPlayButton = false;
      });
    } else {
      setState(() {
        showingPlayButton = true;
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      });
      Timer(
        Duration(milliseconds: long ? 800 : 300),
        (() => setState(() {
              showingPlayButton = false;
            })),
      );
    }
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

  Widget creditsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 40.h),
              Text(
                'CREDITS',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'CREATED and PRODUCED',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'CONCEPT, FILMING, DESING,',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'AUDIO and VIDEO EDITING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Henryk Gajewski',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'LESSONS & DANCING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Arjan Sikking & Marianne van Berlo',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'ORIGINAL MUSIC',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'COMPOSED & PERFORMED',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Carel Kraayenhof',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'FLUTTER APP CODING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Remco Tevreden',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'iOS PROTOTYPE CODING',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Marcin Kowalczyk',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'LOGO DESIGN',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Wytske Wits',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'INFO VIDEO APPEARANCE',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Batoul Lakmoush',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Wouter Bording',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'SPECIAL THANKS',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Arjan Sikking',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Wytske Wits',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                'Marcin Gajewski',
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 15.h),
              Text(
                'COPYRIGHTS',
                style: TextStyle(
                  color: Colors.brown,
                  fontSize: 20.sp,
                ),
              ),
              Text(
                '© Henryk Gajewski, Since 2014',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget subscriptionWidget(
      void Function() monthlyIsClicked, void Function() yearlyIsClicked) {
    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 35.h),
              Text(
                'Watch Premium Content',
                style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.h),
              Text(
                  "Subscribing gets you access to all videos contained in all lessons. Explore and watch videos on phones and tablets.",
                  style: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                  textAlign: TextAlign.center),
              SizedBox(height: 15.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose Your Plan',
                      style: TextStyle(fontSize: 16.w),
                    ),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(5.w),
                      child: Icon(Icons.close, size: 15.w),
                    ),
                  )
                ],
              ),
              SizedBox(height: 15.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  border: Border.all(
                    color: subscriptionIsMonthly
                        ? primaryColor
                        : Colors.grey[300]!,
                    width: subscriptionIsMonthly ? 2 : 1,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'MONTHLY',
                            style: TextStyle(
                                color: Colors.grey[500],
                                letterSpacing: 1.5,
                                fontSize: 14.sp),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "\$XX.XX/Month",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          monthlyIsClicked();
                        },
                        child: Icon(
                          subscriptionIsMonthly
                              ? Icons.radio_button_on
                              : Icons.radio_button_off,
                          color: subscriptionIsMonthly
                              ? primaryColor
                              : Colors.grey[300],
                          size: 26.w,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.w),
                  border: Border.all(
                    color: subscriptionIsMonthly
                        ? Colors.grey[500]!
                        : primaryColor,
                    width: subscriptionIsMonthly ? 1 : 2,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'ANNUALLY',
                            style: TextStyle(
                                color: Colors.grey[500],
                                letterSpacing: 1.5,
                                fontSize: 14.sp),
                          ),
                          SizedBox(height: 15.h),
                          Text(
                            "\$XXX.XX/year",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      InkWell(
                        onTap: () {
                          yearlyIsClicked();
                        },
                        child: Icon(
                          subscriptionIsMonthly
                              ? Icons.radio_button_off
                              : Icons.radio_button_on,
                          color: subscriptionIsMonthly
                              ? Colors.grey[500]
                              : primaryColor,
                          size: 26.w,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 20,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.w),
                    color: primaryColor,
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.w),
                    child: Center(
                      child: Text(
                        'Continue to Checkout',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/videos/info_video.mp4')
      ..initialize().then((_) {
        _controller.setLooping(true);
        _controller.setVolume(0);
        _controller.play();
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
    onPortraitScreenTouch(long: true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/icons/sky_background.png',
                  fit: BoxFit.fill,
                ),
              ),
              SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                padding: EdgeInsets.only(left: 20.w, top: 5.h),
                                child: Image.asset('assets/icons/arrowback.png',
                                    height: 35.h)),
                          ),
                          Container(
                            alignment: Alignment.center,
                            height: 35.h,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child:
                                  Image.asset('assets/icons/milonga_text.png'),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: 15.w),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  isMuted = !isMuted;
                                });
                                isMuted
                                    ? _controller.setVolume(0)
                                    : _controller.setVolume(1);
                              },
                              child: isMuted
                                  ? Image.asset('assets/icons/audio.png',
                                      height: 35.h)
                                  : Image.asset('assets/icons/audioON.png',
                                      height: 35.h),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setState) {
                                  void monthlyIsClicked() {
                                    if (!subscriptionIsMonthly) {
                                      setState(() {
                                        subscriptionIsMonthly = true;
                                      });
                                    }
                                  }

                                  void yearlyIsClicked() {
                                    if (subscriptionIsMonthly) {
                                      setState(() {
                                        subscriptionIsMonthly = false;
                                      });
                                    }
                                  }

                                  return subscriptionWidget(
                                      monthlyIsClicked, yearlyIsClicked);
                                });
                              },
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset('assets/icons/purchase.png',
                                  height: 45.h),
                            ),
                          ),
                          SizedBox(width: 30.w),
                          InkWell(
                            onTap: () => Share.share(
                                'Milonga helps you to learn how to dance using your phone. Download now!\nhttps://example.com',
                                subject: 'Introducing Milonga'),
                            child: Padding(
                              padding: EdgeInsets.all(8.w),
                              child: Image.asset('assets/icons/share.png',
                                  height: 45.h),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      _controller.value.isInitialized
                          ? Stack(
                              children: [
                                AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: VideoPlayer(_controller),
                                ),
                                Positioned.fill(
                                  child: InkWell(
                                    onTap: () => onPortraitScreenTouch(),
                                    child: showingPlayButton
                                        ? SizedBox(
                                            height: 100,
                                            width: 100,
                                            child: Icon(
                                              _controller.value.isPlaying
                                                  ? Icons.play_circle
                                                  : Icons.pause_circle,
                                              size: 80.w,
                                              color: primaryTextColor,
                                            ),
                                          )
                                        : Container(),
                                  ),
                                )
                              ],
                            )
                          : Container(height: 300.h),
                      SizedBox(height: 20.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              _controller.seekTo(const Duration(seconds: 0));
                            },
                            child: Image.asset('assets/icons/play_inactive.png',
                                height: 55.h),
                          ),
                          SizedBox(width: 40.w),
                          InkWell(
                            onTap: () => showModalBottomSheet<void>(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.w),
                              ),
                              context: context,
                              builder: (BuildContext context) {
                                return creditsWidget();
                              },
                            ),
                            child: Image.asset('assets/icons/credits.png',
                                height: 55.h),
                          ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      Text(
                        'LEARN AND DANCE WITH YOUR PHONE',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 18.sp,
                        ),
                      ),
                      Text(
                        'EVERYWHERE',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 25.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const MenuPage()
        ],
      ),
    );
  }
}
