import 'package:get/get.dart';
import 'package:select_location_task/controllers/home_controller.dart';

class DIService{

  static Future<void> init() async{
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
  }

}