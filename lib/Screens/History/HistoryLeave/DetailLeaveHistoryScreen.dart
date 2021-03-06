import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kota_106/Controllers/HistoryController.dart';
import 'package:kota_106/Models/LeaveModel.dart';
import 'package:kota_106/Screens/History/HistoryLeave/EditLeaveHistoryScreen.dart';
import 'package:sizer/sizer.dart';

import '../../DetailAttachmentScreen.dart';

class DetailLeaveHistoryScreen extends GetView<HistoryController> {
  final LeaveModel leaveModel;

  const DetailLeaveHistoryScreen(this.leaveModel);
  @override
  Widget build(BuildContext context) {
    controller.description.text = leaveModel.leaveDescription;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Text(
            'Leave Detail',
            style: TextStyle(fontSize: 14.sp),
          ),
          Container(
            padding: EdgeInsets.only(left: 5.w),
            width: Get.width,
            height: 70.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 4.h,
                ),
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Date Submitted:  ${DateFormat('dd MMMM yyyy').format(DateTime.parse(leaveModel.leaveDateSubmitted))} ',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Text(
                          'Time Submitted:  ${leaveModel.leaveTimeSubmitted}',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          'Leave Type:  ${leaveModel.leaveType}',
                          style: TextStyle(fontSize: 12.sp),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Row(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Start Date: ",
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "${DateFormat('dd MMMM yyyy').format(DateTime.parse(leaveModel.leaveStartDate))}",
                                  style: TextStyle(fontSize: 12.sp),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  "End Date: ",
                                  style: TextStyle(fontSize: 13.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  "${DateFormat('dd MMMM yyyy').format(DateTime.parse(leaveModel.leaveEndDate))}",
                                  style: TextStyle(fontSize: 12.sp),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                    Image.asset(
                      'assets/images/Ellipse2.png',
                      alignment: Alignment.centerLeft,
                    ),
                  ],
                ),
                SizedBox(
                  height: 4.h,
                ),
                Text(
                  'Description',
                  style: TextStyle(fontSize: 12.sp),
                ),
                TextFormField(
                  enabled: false,
                  decoration:
                      InputDecoration(fillColor: Colors.white, filled: true),
                  style: TextStyle(fontSize: 12.sp),
                  maxLines: 4,
                  controller: controller.description,
                ),
                SizedBox(height: 1.h),
                Text('Attachment:', style: TextStyle(fontSize: 12.sp)),
                SizedBox(
                  height: 1.h,
                ),
                Center(
                  child: controller.setImageView(
                      leaveModel.leaveAttachment, 500, 100, "Leave"),
                ),
                SizedBox(height: 1.h),
                Center(
                  child: Container(
                    height: 3.h,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 10,
                            side: BorderSide(color: Colors.amber),
                            primary: Colors.amber),
                        onPressed: () {
                          Get.to(DetailAttachmentScreen(leaveModel.leaveAttachment));
                        },
                        child: Text(
                          "See Full Attachment",
                          style:
                              TextStyle(fontSize: 14.sp, color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 5.h,
            width: 90.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 10,
                    side: BorderSide(color: Colors.amber),
                    primary: Colors.amber),
                onPressed: () {
                  Get.to(EditLeaveHistoryScreen(leaveModel));
                },
                child: Text(
                  "Edit Leave Data",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                )),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 5.h,
            width: 90.w,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    elevation: 10,
                    side: BorderSide(color: Colors.black),
                    primary: Colors.black),
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "Back To History",
                  style: TextStyle(fontSize: 14.sp, color: Colors.white),
                )),
          ),
          SizedBox(height: 2.h),
        ],
      ),
    );
  }
}
