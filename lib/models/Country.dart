import 'Languages.dart';

class Country {
  Country({
      this.typename, 
      this.name, 
      this.native, 
      this.capital, 
      this.currency, 
      this.phone, 
      this.languages,});

  Country.fromJson(dynamic json) {
    typename = json['__typename'];
    name = json['name'];
    native = json['native'];
    capital = json['capital'];
    currency = json['currency'];
    phone = json['phone'];
    if (json['languages'] != null) {
      languages = [];
      json['languages'].forEach((v) {
        languages?.add(Languages.fromJson(v));
      });
    }
  }
  String? typename;
  String? name;
  String? native;
  String? capital;
  String? currency;
  String? phone;
  List<Languages>? languages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    map['name'] = name;
    map['native'] = native;
    map['capital'] = capital;
    map['currency'] = currency;
    map['phone'] = phone;
    if (languages != null) {
      map['languages'] = languages?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}