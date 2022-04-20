import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_location_task/models/Region.dart';
import 'package:select_location_task/models/region_local.dart';
import 'package:select_location_task/services/http_service.dart';

class HomeController extends GetxController{
  var selectedValue = ''.obs;
  var selectedValue2 = ''.obs;
  var selectedValue3 = ''.obs;
  var isLoading = false.obs;
  var regions = <Region>[].obs;
  var districts = <Region>[].obs;
  var industries = <Region>[].obs;
  var storeRegion = RegionLocal().obs;

  Future<void> getRegion() async{
    isLoading.value = true;

    Network.GET(Network.API_GET_REGION, Network.paramsGetRegion()).then((value) {
      if(value != null) {
        _showRegions(value);
      }
      isLoading.value = false;
    });
  }

  _showRegions(String? response) {
    isLoading.value = false;
    if (response != null) {
      regions.value = Network.parseRegions(response);
    }
  }

  Future<void> getDistrict({required regionId}) async{
    isLoading.value = true;

    Network.GET(Network.API_GET_DISTRICT, Network.paramsGetDistrict(regionId: regionId)).then((value) {
      if(value != null) {
        _showDistricts(value);
      }
      isLoading.value = false;
    });
  }

  _showDistricts(String? response) {
    isLoading.value = false;
    if (response != null) {
      districts.value = Network.parseRegions(response);
    }
  }

  Future<void> getIndustry({required districtId}) async{
    isLoading.value = true;

    Network.GET(Network.API_GET_INDUSTRY, Network.paramsGetIndustry(districtId: districtId)).then((value) {
      if(value != null) {
        _showIndustries(value);
      }
      isLoading.value = false;
    });
  }

  _showIndustries(String? response) {
    isLoading.value = false;
    if (response != null) {
      industries.value = Network.parseRegions(response);
    }
  }

  // Widget dropDown({required context, required title, required hintText, required List<Region> list}) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Padding(
  //         padding: const EdgeInsets.only(left: 10),
  //         child: Text(title, style: TextStyle(color: Colors.white, fontSize: 17),),
  //       ),
  //       const SizedBox(height: 10,),
  //       Container(
  //         width: MediaQuery.of(context).size.width * 0.7,
  //         padding: EdgeInsets.symmetric(horizontal: 10),
  //         height: 55,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(20),
  //           color: Colors.green,
  //         ),
  //         alignment: Alignment.center,
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.start,
  //           children: [
  //             Container(
  //               margin: const EdgeInsets.symmetric(horizontal: 5),
  //               alignment: Alignment.center,
  //               // width: MediaQuery.of(context).size.width * 0.3,
  //               child: DropdownButton(
  //                 items:  list.map((text) {
  //                     return DropdownMenuItem(
  //                       child: SizedBox(
  //                         width: MediaQuery.of(context).size.width * 0.55,
  //                         child: Text(text.title!, maxLines: 2,),
  //                       ),
  //                       value: text.title,
  //                     );
  //                   }).toList(),
  //
  //                 value: selectedValue.value.isEmpty ? null : selectedValue.value,
  //                 icon: const SizedBox(),
  //                 underline: const SizedBox(),
  //                 hint: Text(hintText, style: TextStyle(color: Colors.grey.shade400),),
  //                 dropdownColor: Colors.green,
  //                 onChanged: (String? newValue) {
  //                   if(newValue != null) {
  //                     selectedValue.value = newValue;
  //                     int? id = list.firstWhere((element) => element.title == selectedValue.value).id;
  //                     getDistrict(regionId: id);
  //                   }
  //                 },
  //               ),
  //             ),
  //             Spacer(),
  //             Icon(Icons.arrow_drop_down)
  //           ],
  //         ),
  //       )
  //     ],
  //   );
  // }

}