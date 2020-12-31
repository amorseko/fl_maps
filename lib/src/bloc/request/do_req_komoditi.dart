class doReqKomoditi {
  final String name;
  final String mode_query;
  final String id;


  doReqKomoditi({this.name, this.mode_query, this.id});

  factory doReqKomoditi.fromJson(Map<String, dynamic> json) {
    return doReqKomoditi(
      name: json['name'],
      mode_query: json['mode_query'],
      id: json['id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    map["mode_query"] = mode_query;
    map['id'] = id;
    return map;
  }

}