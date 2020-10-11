class doReqKomoditi {
  final String name;


  doReqKomoditi({this.name});

  factory doReqKomoditi.fromJson(Map<String, dynamic> json) {
    return doReqKomoditi(
      name: json['name'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["name"] = name;
    return map;
  }

}