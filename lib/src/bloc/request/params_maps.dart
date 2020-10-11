class reqMapsList {
  final String gapoktan;

  reqMapsList({this.gapoktan});

  factory reqMapsList.fromJson(Map<String, dynamic> json) {
    return reqMapsList(
      gapoktan: json['gapoktan'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["gapoktan"] = gapoktan;
    return map;
  }
}