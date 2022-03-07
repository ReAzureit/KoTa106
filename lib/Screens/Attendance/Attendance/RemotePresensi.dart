import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../Controllers/AttendanceController/AttendanceController.dart';
// import '../../../Models/ScheduleModel.dart';
import 'CheckInForm.dart';
import 'CheckOutForm.dart';

class RemotePresensiPage extends GetView<AttendanceController> {
  @override
  Widget build(BuildContext context) {
    var screenHeightSize = MediaQuery.of(context).size.height;
    // ScheduleModel scheduleModel = Get.put(ScheduleModel());

    var currentTime = controller.time.value;
    // var scheduleStartTime = scheduleModel.startCheckinAt;
    var scheduleStartTime = controller.time.value;
    // var scheduleEndTime = scheduleModel.endCheckinAt;
    var scheduleEndTime = controller.time.value;
    controller.getAddress();
    controller.currentDate();
    const List<Tab> tabs = <Tab>[
      Tab(text: 'Check-in'),
      Tab(text: 'Check-out'),
    ];

    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Center(
              child: Text('Remote Working', style: TextStyle(fontSize: 32)),
            ),
            TabBar(
              indicatorColor: Colors.amberAccent,
              tabs: tabs,
              labelColor: Colors.black,
            ),
            SingleChildScrollView(
              child: Container(
                color: HexColor('F5F5F5F5'),
                height: screenHeightSize / 2,
                child: TabBarView(children: [
                  currentTime == scheduleStartTime &&
                          controller.statusCheckinOnline.value == false
                      ? CheckInForm()
                      : controller.showAlert(),
                  currentTime == scheduleEndTime &&
                          controller.statusCheckinOnline.value == true
                      ? CheckOutForm()
                      : controller.showAlert()
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}