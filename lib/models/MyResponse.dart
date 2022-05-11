import 'Country.dart';

class MyResponse {
  MyResponse({
      this.typename, 
      this.country,});

  MyResponse.fromJson(dynamic json) {
    typename = json['__typename'];
    country = json['country'] != null ? Country.fromJson(json['country']) : null;
  }
  String? typename;
  Country? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    if (country != null) {
      map['country'] = country?.toJson();
    }
    return map;
  }

}