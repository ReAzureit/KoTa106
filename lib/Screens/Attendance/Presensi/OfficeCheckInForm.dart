import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Controllers/AttendanceController/AttendanceController.dart';

class OfficeCheckInForm extends GetView<AttendanceController> {
  const OfficeCheckInForm({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AttendanceController controller = Get.put(AttendanceController());
    var screenHeightSize = MediaQuery.of(context).size.height;
    var screenWidthSize = MediaQuery.of(context).size.width;
    final _formkey = Get.put(GlobalKey<FormState>());
    controller.clocation.text = "CV Garuda Infinity Kreasindo";
    controller.cDateTime.text = controller.date.value;
    controller.cTime.text = controller.time.value;
    return Form(
      key: _formkey,
      child: SingleChildScrollView(
        child: Container(
          height: screenHeightSize,
          padding: EdgeInsets.only(left: 20),
          child: Column(children: [
            Row(children: [
              Image.asset(
                'assets/images/Icon/Location.png',
                width: 40,
                height: 40,
              ),
              Text('Check-in Location'),
            ]),
            Padding(padding: EdgeInsets.only(top: 10)),
            TextFormField(
              maxLines: 1,
              controller: controller.clocation,
              enabled: false,
            ),
            Row(
              children: [
                Image.asset('assets/images/Icon/Calendar.png'),
                Text('Check-in Date'),
                Padding(padding: EdgeInsets.only(left: 80)),
                Image.asset('assets/images/Icon/Clock.png'),
                Text('Check-in Time')
              ],
            ),
            Row(
              children: [
                Container(
                  width: screenWidthSize / 2,
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    decoration:
                        InputDecoration(disabledBorder: InputBorder.none),
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    controller: controller.cDateTime,
                    enabled: false,
                  ),
                ),
                Container(
                  width: screenWidthSize / 2 - 20,
                  child: TextFormField(
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration(disabledBorder: InputBorder.none),
                    style: TextStyle(fontSize: 12),
                    maxLines: 1,
                    controller: controller.cTime,
                    enabled: false,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Image.asset('assets/images/Icon/Note.png'),
                Text('You Want To...'),
              ],
            ),
            TextFormField(
              style: TextStyle(fontSize: 12),
              maxLines: 4,
              controller: controller.note,
            ),
            Container(
                width: screenWidthSize,
                child: ElevatedButton(
                    onPressed: () {}, child: Text('Check-in Now')))
          ]),
        ),
      ),
    );
  }
}