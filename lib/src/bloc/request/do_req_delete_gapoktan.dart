class reqDelGapoktan {
  final String id_gapoktan;

  reqDelGapoktan({this.id_gapoktan});

  factory reqDelGapoktan.fromJson(Map<String, dynamic> json) {
    return reqDelGapoktan(
      id_gapoktan: json['id_gapoktan'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id_gapoktan"] = id_gapoktan;
    return map;
  }
}