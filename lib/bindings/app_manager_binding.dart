import 'package:app_manager/controller/app_manager_controller.dart';
import 'package:app_manager/controller/backup_controller.dart';
import 'package:app_manager/controller/check_controller.dart';
import 'package:app_manager/controller/icon_controller.dart';
import 'package:app_manager/controller/mark_controller.dart';
import 'package:get/get.dart';
import 'package:global_repository/global_repository.dart';

class AppManagerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppManagerController());
    Get.put(CheckController());
    Get.put(MarkController());
    Get.put(BackupController());
    Get.put(IconController());
  }
}
