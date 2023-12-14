class ReferModel {
  String? message;
  bool? status;
  ReferDatum? data;

  ReferModel({
    this.message,
    this.status,
    this.data,
  });

  factory ReferModel.fromJson(Map<String, dynamic> json) => ReferModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null ? null : ReferDatum.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data?.toJson(),
      };
}

class ReferDatum {
  List<Referral>? referrals;
  int? coins;
  int? count;
  dynamic refbonus;
  dynamic mincoinsearned;

  ReferDatum(
      {this.referrals,
      this.coins,
      this.count,
      this.refbonus,
      this.mincoinsearned});

  factory ReferDatum.fromJson(Map<String, dynamic> json) => ReferDatum(
        referrals: json["referrals"] == null
            ? []
            : List<Referral>.from(
                json["referrals"]!.map((x) => Referral.fromJson(x))),
        coins: json["coins"],
        count: json["count"],
        refbonus: json["referral_bonus"],
        mincoinsearned: json["min_coins_earned"],
      );

  Map<String, dynamic> toJson() => {
        "referrals": referrals == null
            ? []
            : List<dynamic>.from(referrals!.map((x) => x.toJson())),
        "coins": coins,
        "count": count,
        "refbonus": refbonus,
        "mincoinsearned": mincoinsearned
      };
}

class Referral {
  int? uId;
  String? uName;
  int? referredBy;
  int? uMobno;
  String? uEmail;
  DateTime? uDob;
  int? uCurrAge;
  int? uGender;
  String? createdAt;

  Referral({
    this.uId,
    this.uName,
    this.referredBy,
    this.uMobno,
    this.uEmail,
    this.uDob,
    this.uCurrAge,
    this.uGender,
    this.createdAt,
  });

  factory Referral.fromJson(Map<String, dynamic> json) => Referral(
        uId: json["u_id"],
        uName: json["u_name"],
        referredBy: json["referred_by"],
        uMobno: json["u_mobno"],
        uEmail: json["u_email"],
        uDob: json["u_dob"] == null ? null : DateTime.parse(json["u_dob"]),
        uCurrAge: json["u_curr_age"],
        uGender: json["u_gender"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "u_id": uId,
        "u_name": uName,
        "referred_by": referredBy,
        "u_mobno": uMobno,
        "u_email": uEmail,
        "u_dob":
            "${uDob!.year.toString().padLeft(4, '0')}-${uDob!.month.toString().padLeft(2, '0')}-${uDob!.day.toString().padLeft(2, '0')}",
        "u_curr_age": uCurrAge,
        "u_gender": uGender,
        "created_at": createdAt,
      };
}
