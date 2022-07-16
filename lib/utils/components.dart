import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'appColors.dart';

void customScaffoldMessage(BuildContext context, String message,
    {Duration? duration}) {
  var snackBar = SnackBar(
    content: Text(message),
    duration: duration ?? const Duration(seconds: 2),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

void showPurchasePopup(BuildContext context) {
  bool subscriptionIsMonthly = true;

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

  showModalBottomSheet<void>(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10.w),
        topRight: Radius.circular(10.w),
      ),
    ),
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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

        return subscriptionWidget(monthlyIsClicked, yearlyIsClicked);
      });
    },
  );
}
