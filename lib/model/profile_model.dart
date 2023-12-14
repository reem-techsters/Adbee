class ProfileModel {
  String? message;
  bool? status;
  List<PDatum>? data;

  ProfileModel({
    this.message,
    this.status,
    this.data,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PDatum>.from(json["data"]!.map((x) => PDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class PDatum {
  String? userUniqueId;
  String? uImage;
  String? referralCode;
  int? uMobno;
  String? uName;
  String? uEmail;
  DateTime? uDob;
  int? uCurrAge;
  int? uGender;
  int? uProfession;
  int? uState;
  int? uDistrict;
  String? uPincode;
  String? uFirstLog;
  String? status;
  String? walletBalance;
  String? uBankAccNo;
  String? uIfsc;
  String? uUpi;
  dynamic referredBy;
  int? coinPrice;

  PDatum(
      {this.userUniqueId,
      this.uImage,
      this.referralCode,
      this.uMobno,
      this.uName,
      this.uEmail,
      this.uDob,
      this.uCurrAge,
      this.uGender,
      this.uProfession,
      this.uState,
      this.uDistrict,
      this.uPincode,
      this.uFirstLog,
      this.status,
      this.walletBalance,
      this.uBankAccNo,
      this.uIfsc,
      this.uUpi,
      this.referredBy,
      this.coinPrice});

  factory PDatum.fromJson(Map<String, dynamic> json) => PDatum(
      userUniqueId: json["user_unique_id"],
      uImage: json["u_image"],
      referralCode: json["referral_code"],
      uMobno: json["u_mobno"],
      uName: json["u_name"],
      uEmail: json["u_email"],
      uDob: json["u_dob"] == null ? null : DateTime.parse(json["u_dob"]),
      uCurrAge: json["u_curr_age"],
      uGender: json["u_gender"],
      uProfession: json["u_profession"],
      uState: json["u_state"],
      uDistrict: json["u_district"],
      uPincode: json["u_pincode"],
      uFirstLog: json["u_first_log"],
      status: json["status"],
      walletBalance: json["wallet_balance"],
      uBankAccNo: json["u_bank_acc_no"],
      uIfsc: json["u_ifsc"],
      uUpi: json["u_upi"],
      referredBy: json["referred_by"],
      coinPrice: json["coin_price"]);

  Map<String, dynamic> toJson() => {
        "user_unique_id": userUniqueId,
        "u_image": uImage,
        "referral_code": referralCode,
        "u_mobno": uMobno,
        "u_name": uName,
        "u_email": uEmail,
        "u_dob":
            "${uDob!.year.toString().padLeft(4, '0')}-${uDob!.month.toString().padLeft(2, '0')}-${uDob!.day.toString().padLeft(2, '0')}",
        "u_curr_age": uCurrAge,
        "u_gender": uGender,
        "u_profession": uProfession,
        "u_state": uState,
        "u_district": uDistrict,
        "u_pincode": uPincode,
        "u_first_log": uFirstLog,
        "status": status,
        "wallet_balance": walletBalance,
        "u_bank_acc_no": uBankAccNo,
        "u_ifsc": uIfsc,
        "u_upi": uUpi,
        "referred_by": referredBy,
        "coin_price": coinPrice
      };
}
