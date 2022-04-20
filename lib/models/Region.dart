import 'dart:convert';
/// id : 1703
/// title : "Андижанская область"

Region regionFromJson(String str) => Region.fromJson(json.decode(str));
String regionToJson(Region data) => json.encode(data.toJson());
class Region {
  Region({
      this.id, 
      this.title,});

  Region.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
  }
  int? id;
  String? title;
Region copyWith({  int? id,
  String? title,
}) => Region(  id: id ?? this.id,
  title: title ?? this.title,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }

}