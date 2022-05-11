class Languages {
  Languages({
      this.typename, 
      this.code, 
      this.name,});

  Languages.fromJson(dynamic json) {
    typename = json['__typename'];
    code = json['code'];
    name = json['name'];
  }
  String? typename;
  String? code;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['__typename'] = typename;
    map['code'] = code;
    map['name'] = name;
    return map;
  }

}