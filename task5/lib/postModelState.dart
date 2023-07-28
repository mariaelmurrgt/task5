import 'dart:convert';

PostModelState postModelStateFromJson(String str) =>
    PostModelState.fromJson(json.decode(str));

String postModelStateToJson(PostModelState data) => json.encode(data.toJson());

class PostModelState {
  String idState;
  String stateName;
  String stateCode;
  List<CityVoList> cityVoList;

  PostModelState({
    required this.idState,
    required this.stateName,
    required this.stateCode,
    required this.cityVoList,
  });

  factory PostModelState.fromJson(Map<String, dynamic> json) => PostModelState(
        idState: json["idState"],
        stateName: json["stateName"],
        stateCode: json["stateCode"],
        cityVoList: List<CityVoList>.from(
            json["cityVOList"].map((x) => CityVoList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "idState": idState,
        "stateName": stateName,
        "stateCode": stateCode,
        "cityVOList": List<dynamic>.from(cityVoList.map((x) => x.toJson())),
      };
}

class CityVoList {
  String idCity;
  String cityName;

  CityVoList({
    required this.idCity,
    required this.cityName,
  });

  factory CityVoList.fromJson(Map<String, dynamic> json) => CityVoList(
        idCity: json["idCity"],
        cityName: json["cityName"],
      );

  Map<String, dynamic> toJson() => {
        "idCity": idCity,
        "cityName": cityName,
      };
}
