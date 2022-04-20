import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:select_location_task/models/region_local.dart';

class HiveDB{
  static String DB_NAME = "store_region";
  static var box = Hive.box(DB_NAME);

  static Future<void> store(String data) async{
    await box.put('region', data);
  }

  static Future<RegionLocal?> load() async{
    var result = await box.get("region");
    log(regionLocalFromJson(result).district.toString());

    return regionLocalFromJson(result);
  }

  static void remove() async{
    await box.delete('region');
  }

}