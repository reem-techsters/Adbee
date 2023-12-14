class BankModel {
  String? message;
  bool? status;
  List<BDatum>? data;

  BankModel({
    this.message,
    this.status,
    this.data,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<BDatum>.from(json["data"]!.map((x) => BDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BDatum {
  String? userUniqueId;
  String? referralCode;
  int? uMobno;
  int? uCurrAge;
  int? uGender;
  int? uState;
  int? uDistrict;
  String? uPincode;
  String? uFirstLog;
  String? status;
  String? walletBalance;
  dynamic uBankAccNo;
  dynamic uIfsc;
  dynamic referredBy;
  dynamic uupi;

  BDatum(
      {this.userUniqueId,
      this.referralCode,
      this.uMobno,
      this.uCurrAge,
      this.uGender,
      this.uState,
      this.uDistrict,
      this.uPincode,
      this.uFirstLog,
      this.status,
      this.walletBalance,
      this.uBankAccNo,
      this.uIfsc,
      this.referredBy,
      this.uupi});

  factory BDatum.fromJson(Map<String, dynamic> json) => BDatum(
      userUniqueId: json["user_unique_id"],
      referralCode: json["referral_code"],
      uMobno: json["u_mobno"],
      uCurrAge: json["u_curr_age"],
      uGender: json["u_gender"],
      uState: json["u_state"],
      uDistrict: json["u_district"],
      uPincode: json["u_pincode"],
      uFirstLog: json["u_first_log"],
      status: json["status"],
      walletBalance: json["wallet_balance"],
      uBankAccNo: json["u_bank_acc_no"],
      uIfsc: json["u_ifsc"],
      referredBy: json["referred_by"],
      uupi: json["u_upi"]);

  Map<String, dynamic> toJson() => {
        "user_unique_id": userUniqueId,
        "referral_code": referralCode,
        "u_mobno": uMobno,
        "u_curr_age": uCurrAge,
        "u_gender": uGender,
        "u_state": uState,
        "u_district": uDistrict,
        "u_pincode": uPincode,
        "u_first_log": uFirstLog,
        "status": status,
        "wallet_balance": walletBalance,
        "u_bank_acc_no": uBankAccNo,
        "u_ifsc": uIfsc,
        "referred_by": referredBy,
        "u_upi": uupi,
      };
}
