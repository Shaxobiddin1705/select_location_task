import 'dart:convert';
/// id : 1703
/// title : "Андижанская область"

RegionLocal regionLocalFromJson(String str) => RegionLocal.fromJson(json.decode(str));
String regionLocalToJson(RegionLocal data) => json.encode(data.toJson());
class RegionLocal {
  RegionLocal({this.region, this.district, this.industry});

  RegionLocal.fromJson(dynamic json) {
    region = json['region'];
    district = json['district'];
    industry = json['industry'];
  }
  String? region;
  String? district;
  String? industry;
  RegionLocal copyWith({  String? region,
    String? district, String? industry
  }) => RegionLocal(  region: region ?? this.region, district: district ?? this.district, industry: industry ?? this.industry,);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['region'] = region;
    map['district'] = district;
    map['industry'] = industry;
    return map;
  }

}