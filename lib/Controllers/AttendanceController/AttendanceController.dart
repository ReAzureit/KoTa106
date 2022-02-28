import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

import 'package:geocoding/geocoding.dart' hide Location;

import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../Screens/Attendance/Presensi/OfficePresensi.dart';
import '../APIService/ApiService.dart';
import '../CacheManager.dart';

class AttendanceController extends GetxController with CacheManager {
  QRViewController? controller;
  ApiClient _apiClient = Get.put(ApiClient(Dio()));
  Barcode? result;
  var statusScan = false.obs;
  late Location location;
  late LocationData _locationData;
  late TextEditingController clocation;
  late TextEditingController cDateTime;
  late TextEditingController cTime;
  late TextEditingController note;
  late RxString currentAddress;
  late RxBool _permission;
  late RxString date;
  late RxString time;
  late RxString nameMonth;
  late Rx<File> tmpFile;
  late Rx<XFile> imageFile;
  late Rx<bool> event;
  late RxString photoName;
  late String token;
  late int id;
  late int scheduleId;
  late String? testing;

  @override
  void onInit() async {
    location = new Location();
    _permission = false.obs;
    currentAddress = "".obs;
    event = false.obs;
    date = "".obs;
    time = "".obs;
    nameMonth = "".obs;
    photoName = "".obs;
    tmpFile = File('').obs;
    imageFile = XFile('').obs;

    // token = 'Bearer ${getToken()}';
    // id = getUserId();
    // scheduleId = getScheduleId();

     token = 'Bearer';
    id = 0 ;
    scheduleId = 0;

    await getPermission();
    getAddress();
    currentDate();
    clocation = TextEditingController();
    cDateTime = TextEditingController();
    cTime = TextEditingController();
    note = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    controller?.dispose();
    super.onClose();
  }

  Future<bool> getPermission() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return false;
      }
    }
    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }
    _permission.value = true;
    return true;
  }

  Future<void> getAddress() async {
    if (_permission.value) {
      _locationData = await location.getLocation();
      List<Placemark> p = await GeocodingPlatform.instance
          .placemarkFromCoordinates(
              _locationData.latitude!, _locationData.longitude!);
      Placemark place = p[0];
      currentAddress.value =
          "${place.thoroughfare}-${place.locality}- ${place.postalCode}-${place.subAdministrativeArea}";
    }
    update();
  }

  void openImage(ImageSource imageSourceCamera) async {
    ImagePicker _image = Get.put(ImagePicker());
    try {
      imageFile.value = (await _image.pickImage(source: imageSourceCamera))!;
      print(imageFile.value.name);
      photoName.value = imageFile.value.name;
    } catch (e) {
      // return 'Terjadi Kesalahan';
    }
  }

  Widget setImageView() {
    if (imageFile.value.path != '') {
      tmpFile.value = File(imageFile.value.path);
      return Image.file(tmpFile.value, width: 100, height: 100);
    } else {
      return Image.asset(
        'assets/images/Icon/AccountBox.png',
        width: 100,
        height: 100,
      );
    }
  }

  Future<void> currentDate() async {
    String rawDate = "";
    WidgetsFlutterBinding.ensureInitialized();
    await initializeDateFormatting('id_ID', null).then((_) => rawDate =
        '${DateFormat("MMMM yyyy-MM-dd hh:mm", "id_ID").format(DateTime.now())}');
    List<String> formatedDate = rawDate.split(' ');
    nameMonth.value = formatedDate[0];
    date.value = formatedDate[1];
    time.value = formatedDate[2];
    update();
  }

  Widget showAlert() {
    return Container(
      child: Center(
          child: Text(
        'Tidak ada jadwal untuk saat ini',
        style: TextStyle(fontFamily: 'ROBOTO', fontSize: 16),
      )),
    );
  }

  Widget scanQRPage(GlobalKey qrKey, BuildContext context) {
    return QRView(
        key: qrKey,
        onQRViewCreated: (controller) {
          controller.scannedDataStream.listen((scanData) async {
            statusScan.value = true;
            time.value = scanData.code!;
            controller.pauseCamera();
            showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return OfficePresensiPage();
                });
          });
        });
  }

  void dialog(String message, String content) {
    Get.defaultDialog(
      radius: 10.0,
      contentPadding: const EdgeInsets.all(20.0),
      title: message,
      titleStyle: TextStyle(fontFamily: 'ROBOTO'),
      middleText: content,
      textConfirm: 'Confirm',
      confirm: OutlinedButton.icon(
        onPressed: () => Get.back(),
        icon: const Icon(
          Icons.check,
          color: Colors.blue,
        ),
        label: const Text(
          'Confirm',
          style: TextStyle(color: Colors.blue),
        ),
      ),
    );
  }

  void checkInOnline(
      String location, String checkInTime, String description) async {
    try {
      await _apiClient
          .checkinOnline(id, scheduleId, location, photoName.value, checkInTime,
              description, token)
          .then((response) {
        print(response.status);
        if (response.status == 200) {
          dialog('SUCCESS', 'CHECK-IN BERHASIL');
        } else {
          dialog('ALERT', 'CHECK-IN GAGAL');
        }
      });
    } catch (e) {
      dialog('ALERT', 'TERJADI KESALAHAN, SILAHKAN ULANGI');
    }
  }

  void checkOutOnline(
      String location, String checkInTime, String description) async {}
}