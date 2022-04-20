import 'dart:convert';

import 'package:http/http.dart';
import 'package:select_location_task/models/Region.dart';

class Network{

  static String baseApi = "my2.dev.gov.uz";

  static Map<String, String> headers = {'Content-type': 'application/json'};


  /* Http Requests */

  static Future<String?> GET(String api, Map<String, dynamic> params) async {
    var uri = Uri.http(baseApi, api, params); // http or https
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) return response.body;
    return null;
  }

  /* Http Apis */
  static String API_GET_REGION = "/azamat/ru/weather/get-regions";
  static String API_GET_DISTRICT = "/azamat/ru/weather/get-districts";
  static String API_GET_INDUSTRY = "/azamat/ru/weather/get-organizations";

  /* Http Params */
  static Map<String, String> paramsGetRegion() {
    Map<String, String> params = {};
    return params;
  }

  static Map<String, String> paramsGetDistrict({required regionId}) {
    Map<String, String> params = {};
    params.addAll({
      'regionId' : regionId.toString()
    });
    return params;
  }

  static Map<String, String> paramsGetIndustry({required districtId}) {
    Map<String, String> params = {};
    params.addAll({
      'districtId' : districtId.toString()
    });
    return params;
  }


  static List<Region> parseRegions(String response) {
    List json = jsonDecode(response);
    List<Region> regions = List<Region>.from(json.map((x) => Region.fromJson(x)));
    return regions;
  }

}