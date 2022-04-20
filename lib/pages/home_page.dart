import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:select_location_task/controllers/home_controller.dart';
import 'package:select_location_task/models/Region.dart';
import 'package:select_location_task/models/region_local.dart';
import 'package:select_location_task/services/hive_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var controller = Get.find<HomeController>();
  

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    HiveDB.load().then((value) {
      if(value != null) {
        controller.storeRegion.value.region = value.region;
        log(controller.storeRegion.value.region.toString());
        controller.storeRegion.value.district = value.district;
        controller.storeRegion.value.industry = value.industry;
      }
    });
    controller.getRegion();
    log(controller.regions.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade800,
      body: GetX<HomeController>(
        init: HomeController(),
        builder: (_) => SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 200,
                      width: 200,
                      child: Image.asset('assets/images/gerb.png',),
                    ),

                    const SizedBox(height: 30,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Регион', style: TextStyle(color: Colors.white, fontSize: 17),),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                // width: MediaQuery.of(context).size.width * 0.3,
                                child: DropdownButton(
                                  items:  controller.regions.map((text) {
                                    return DropdownMenuItem(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.55,
                                        child: Text(text.title!, maxLines: 2,),
                                      ),
                                      value: text.title,
                                    );
                                  }).toList(),
                                  value: controller.selectedValue.value.isEmpty ? null : controller.selectedValue.value,
                                  icon: const SizedBox(),
                                  underline: const SizedBox(),
                                  hint: Text(
                                    controller.storeRegion.value.region == null ? 'Выберите регион' : controller.storeRegion.value.region.toString(),
                                    style: TextStyle(color: controller.storeRegion.value.region == null ? Colors.grey.shade400 : Colors.black),),
                                  dropdownColor: Colors.green,
                                  onChanged: (String? newValue) {
                                    if(controller.districts.isNotEmpty || controller.industries.isNotEmpty) {
                                      controller.districts.clear();
                                      controller.selectedValue2.value = '';
                                      controller.industries.clear();
                                      controller.selectedValue3.value = '';
                                    }
                                    if(newValue != null) {
                                      controller.storeRegion.value.region = null;
                                      controller.storeRegion.value.district = null;
                                      controller.storeRegion.value.industry = null;
                                      HiveDB.remove();
                                      controller.selectedValue.value = newValue;
                                      int? id = controller.regions.firstWhere((element) => element.title == controller.selectedValue.value).id;
                                      controller.getDistrict(regionId: id);
                                    }
                                  },
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 40,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Район', style: TextStyle(color: Colors.white, fontSize: 17),),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                // width: MediaQuery.of(context).size.width * 0.3,
                                child: DropdownButton(
                                  items:  controller.districts.map((text) {
                                    return DropdownMenuItem(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.55,
                                        child: Text(text.title!, maxLines: 2,),
                                      ),
                                      value: text.title,
                                    );
                                  }).toList(),

                                  value: controller.selectedValue2.value.isEmpty ? null : controller.selectedValue2.value,
                                  icon: const SizedBox(),
                                  underline: const SizedBox(),
                                  hint: Text(
                                    controller.storeRegion.value.region == null ? 'Выберите район' : controller.storeRegion.value.district.toString(),
                                    style: TextStyle(color: controller.storeRegion.value.region == null ? Colors.grey.shade400 : Colors.black),),
                                  dropdownColor: Colors.green,
                                  onChanged: (String? newValue) {
                                    if(controller.industries.isNotEmpty) {
                                      controller.industries.clear();
                                      controller.selectedValue3.value = '';
                                    }
                                    if(newValue != null) {
                                      controller.storeRegion.value.region = null;
                                      controller.storeRegion.value.district = null;
                                      controller.storeRegion.value.industry = null;
                                      HiveDB.remove();
                                      controller.selectedValue2.value = newValue;
                                      int? id = controller.districts.firstWhere((element) => element.title == controller.selectedValue2.value).id;
                                      controller.getIndustry(districtId: id);
                                    }
                                  },
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )
                      ],
                    ),

                    // controller.dropDown(context: context, title: 'Район', hintText: 'Выберите район', list: controller.districts),

                    const SizedBox(height: 40,),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text('Учреждение', style: TextStyle(color: Colors.white, fontSize: 17),),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.7,
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          height: 55,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          alignment: Alignment.center,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 5),
                                alignment: Alignment.center,
                                // width: MediaQuery.of(context).size.width * 0.3,
                                child: DropdownButton(
                                  items:  controller.industries.map((text) {
                                    return DropdownMenuItem(
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.55,
                                        child: Text(text.title!, maxLines: 2,),
                                      ),
                                      value: text.title,
                                    );
                                  }).toList(),

                                  value: controller.selectedValue3.value.isEmpty ? null : controller.selectedValue3.value,
                                  icon: const SizedBox(),
                                  underline: const SizedBox(),
                                  hint: SizedBox(
                                    width: MediaQuery.of(context).size.width * 0.55,
                                    child: Text(
                                      controller.storeRegion.value.region == null ? 'Выберите учреждение' : controller.storeRegion.value.industry.toString(),
                                      maxLines: 1,
                                      style: TextStyle(color: controller.storeRegion.value.region == null ? Colors.grey.shade400 : Colors.black),),
                                  ),
                                  dropdownColor: Colors.green,
                                  onChanged: (String? newValue) {
                                    if(newValue != null) {
                                      controller.storeRegion.value.region = null;
                                      controller.storeRegion.value.district = null;
                                      controller.storeRegion.value.industry = null;
                                      HiveDB.remove();
                                      controller.selectedValue3.value = newValue;
                                    }
                                    if(controller.selectedValue.isNotEmpty && controller.selectedValue2.isNotEmpty && controller.selectedValue3.isNotEmpty) {
                                      controller.storeRegion.value.region = controller.selectedValue.value;
                                      controller.storeRegion.value.district = controller.selectedValue2.value;
                                      controller.storeRegion.value.industry = controller.selectedValue3.value;
                                      HiveDB.store(regionLocalToJson(controller.storeRegion.value));
                                    }
                                  },
                                ),
                              ),
                              Spacer(),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        )
                      ],
                    ),

                    // controller.dropDown(context: context, title: 'Учреждение', hintText: 'Выберите учреждение', list: []),

                    const SizedBox(height: 40,),

                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      minWidth: 150,
                      height: 45,
                      onPressed: (){},
                      color: Colors.amber,
                      child: const Text('Начать', style: TextStyle(fontSize: 17),),
                    )
                  ],
                ),
              ),
              controller.isLoading() ? const Center(child: CircularProgressIndicator(),) : SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
