import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kota_106/Controllers/CacheManager.dart';
import 'package:kota_106/Models/AfterOvertimeModel.dart';
import 'package:time_range_picker/time_range_picker.dart';

import 'APIService/ApiService.dart';

class OvertimeController extends GetxController with CacheManager {
  ApiClient _apiClient = Get.put(ApiClient(Dio()));
  AfterOvertimeModel afterOvertimeModel = Get.put(AfterOvertimeModel());
  TextEditingController overtimeDate = TextEditingController();
  TextEditingController overtimeDescription = TextEditingController();

  Rx<DateTime> overtimeSelectedDate = DateTime.now().obs;
  Rx<TimeOfDay> overtimeStartTime = TimeOfDay(hour: 7, minute: 0).obs;
  Rx<TimeOfDay> overtimeEndTime = TimeOfDay(hour: 17, minute: 0).obs;
  int id = -1;
  String token = "";
  void overtimeDatePicker(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: overtimeSelectedDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.january, 0));

    if (newDate == null) {
    } else {
      overtimeSelectedDate.value = newDate;
    }
  }

  void editOvertimeDatePicker(BuildContext context) async {
    DateTime? newDate = await showDatePicker(
        context: context,
        initialDate: overtimeSelectedDate.value,
        firstDate: DateTime(DateTime.now().year, DateTime.january),
        lastDate: DateTime(DateTime.now().year + 1, DateTime.january, 0));

    if (newDate == null) {
    } else {
      overtimeSelectedDate.value = newDate;
    }
  }

  void overtimeTimePicker(BuildContext context) async {
    TimeRange? newTime = await showTimeRangePicker(
      context: context,
      interval: Duration(minutes: 5),
      start: overtimeStartTime.value,
      end: overtimeEndTime.value,
      maxDuration: Duration(hours: 8),
      disabledColor: Colors.white,
      strokeColor: HexColor("FCBC45"),
      ticksColor: HexColor("FCBC45"),
      handlerColor: HexColor("FCBC45"),
      selectedColor: HexColor("FCBC45").withOpacity(0.5),
    );
    if (newTime == null) {
    } else {
      overtimeStartTime.value = newTime.startTime;
      overtimeEndTime.value = newTime.endTime;
    }
  }

  void overtimeForm() async {
    Get.defaultDialog(
      radius: 10.0,
      contentPadding: const EdgeInsets.all(20.0),
      title: 'SUCCESS',
      titleStyle: TextStyle(color: Colors.green),
      middleText: 'Pengajuan lembur tanggal $overtimeSelectedDate berhasil',
      textConfirm: 'Confirm',
      confirm: OutlinedButton.icon(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.check,
          color: Colors.green,
        ),
        label: const Text(
          'Confirm',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  // Future<void> afterOvertime(int idOvertime) async {
  //   id = getUserId()!;
  //   token = getToken()!;
  //   await _apiClient
  //       .getAfterOvertimeHistory("UserId = $id", "-CreatedAt", 1, 20, token)
  //       .then((response) {
  //     afterOvertimeModel = response.data.data.;
  //   });
  // }
}
