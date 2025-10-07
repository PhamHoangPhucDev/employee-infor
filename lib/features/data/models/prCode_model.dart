class PrCodeModel {
  int? id;
  String? name;
  String? subname;
  dynamic body1;
  PrCodeModel({this.id, this.name, this.subname,this.body1});

  factory PrCodeModel.fromJson(Map<String, dynamic> json) {
    return PrCodeModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      subname: json['subname'] ?? '',
      body1: json['body1'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subname': subname,
        'body1': body1,
      };
}
