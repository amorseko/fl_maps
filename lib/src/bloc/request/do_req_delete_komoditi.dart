class reqDelKomoditi {
  final String id;

  reqDelKomoditi({this.id});

  factory reqDelKomoditi.fromJson(Map<String, dynamic> json) {
    return reqDelKomoditi(
      id: json['id'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    return map;
  }
}