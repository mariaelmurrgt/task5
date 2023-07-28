import 'dart:convert';

PostModelCountry postModelCountryFromJson(String str) =>
    PostModelCountry.fromJson(json.decode(str));

String postModelCountryToJson(PostModelCountry data) =>
    json.encode(data.toJson());

class PostModelCountry {
  String idCountry;
  String countryName;
  String countryCode;
  String isoCode2;
  String isoCode3;

  PostModelCountry({
    required this.idCountry,
    required this.countryName,
    required this.countryCode,
    required this.isoCode2,
    required this.isoCode3,
  });

  factory PostModelCountry.fromJson(Map<String, dynamic> json) =>
      PostModelCountry(
        idCountry: json["idCountry"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        isoCode2: json["isoCode2"],
        isoCode3: json["isoCode3"],
      );

  Map<String, dynamic> toJson() => {
        "idCountry": idCountry,
        "countryName": countryName,
        "countryCode": countryCode,
        "isoCode2": isoCode2,
        "isoCode3": isoCode3,
      };
}
