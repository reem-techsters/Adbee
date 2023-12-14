class LookUpModel {
  List<Gender>? genders;
  List<Profession>? professions;
  List<StateLookUp>? states;

  LookUpModel({
    this.genders,
    this.professions,
    this.states,
  });

  factory LookUpModel.fromJson(Map<String, dynamic> json) => LookUpModel(
        genders: json["genders"] == null
            ? []
            : List<Gender>.from(
                json["genders"]!.map((x) => Gender.fromJson(x))),
        professions: json["professions"] == null
            ? []
            : List<Profession>.from(
                json["professions"]!.map((x) => Profession.fromJson(x))),
        states: json["states"] == null
            ? []
            : List<StateLookUp>.from(json["states"]!.map((x) => StateLookUp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genders": genders == null
            ? []
            : List<dynamic>.from(genders!.map((x) => x.toJson())),
        "professions": professions == null
            ? []
            : List<dynamic>.from(professions!.map((x) => x.toJson())),
        "states": states == null
            ? []
            : List<dynamic>.from(states!.map((x) => x.toJson())),
      };
}

class Gender {
  int? id;
  String? gender;

  Gender({
    this.id,
    this.gender,
  });

  factory Gender.fromJson(Map<String, dynamic> json) => Gender(
        id: json["id"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "gender": gender,
      };
}

class Profession {
  int? id;
  String? name;

  Profession({
    this.id,
    this.name,
  });

  factory Profession.fromJson(Map<String, dynamic> json) => Profession(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class StateLookUp {
  int? stateId;
  String? stateName;
  List<District>? districts;

  StateLookUp({
    this.stateId,
    this.stateName,
    this.districts,
  });

  factory StateLookUp.fromJson(Map<String, dynamic> json) => StateLookUp(
        stateId: json["state_id"],
        stateName: json["state_name"],
        districts: json["districts"] == null
            ? []
            : List<District>.from(
                json["districts"]!.map((x) => District.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "state_id": stateId,
        "state_name": stateName,
        "districts": districts == null
            ? []
            : List<dynamic>.from(districts!.map((x) => x.toJson())),
      };
}

class District {
  int? districtId;
  String? districtName;
  int? stateId;

  District({
    this.districtId,
    this.districtName,
    this.stateId,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
        districtId: json["district_id"],
        districtName: json["district_name"],
        stateId: json["state_id"],
      );

  Map<String, dynamic> toJson() => {
        "district_id": districtId,
        "district_name": districtName,
        "state_id": stateId,
      };
}
