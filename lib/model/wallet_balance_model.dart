// class WalletBalanceModel {
//   String? message;
//   bool? status;
//   List<Datum>? data;

//   WalletBalanceModel({
//     this.message,
//     this.status,
//     this.data,
//   });

//   factory WalletBalanceModel.fromJson(Map<String, dynamic> json) =>
//       WalletBalanceModel(
//         message: json["message"],
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class Datum {
//   String? userUniqueId;
//   String? referralCode;
//   int? uMobno;
//   String? uName;
//   String? uEmail;
//   DateTime? uDob;
//   int? uCurrAge;
//   int? uGender;
//   String? uImage;
//   // String? uFirstLog;
//   // String? status;
//   String? walletBalance;
//   // dynamic referredBy;

//   Datum({
//     this.userUniqueId,
//     this.referralCode,
//     this.uMobno,
//     this.uName,
//     this.uEmail,
//     this.uDob,
//     this.uCurrAge,
//     this.uGender,
//     this.uImage,
//     this.uProfession,
//     this.uState,
//     this.uDistrict,
//     this.uPincode,
//     this.uFirstLog,
//     this.status,
//     this.walletBalance,
//     this.uBankAccNo,
//     this.uIfsc,
//     this.uUpi,
//     this.referredBy,
//   });

//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//         userUniqueId: json["user_unique_id"],
//         referralCode: json["referral_code"],
//         uMobno: json["u_mobno"],
//         uName: json["u_name"],
//         uEmail: json["u_email"],
//         uDob: json["u_dob"] == null ? null : DateTime.parse(json["u_dob"]),
//         uCurrAge: json["u_curr_age"],
//         uGender: json["u_gender"],
//         uImage: json["u_image"],
//         uProfession: json["u_profession"],
//         uState: json["u_state"],
//         uDistrict: json["u_district"],
//         uPincode: json["u_pincode"],
//         uFirstLog: json["u_first_log"],
//         status: json["status"],
//         walletBalance: json["wallet_balance"],
//         uBankAccNo: json["u_bank_acc_no"],
//         uIfsc: json["u_ifsc"],
//         uUpi: json["u_upi"],
//         referredBy: json["referred_by"],
//       );

//   Map<String, dynamic> toJson() => {
//         "user_unique_id": userUniqueId,
//         "referral_code": referralCode,
//         "u_mobno": uMobno,
//         "u_name": uName,
//         "u_email": uEmail,
//         "u_dob":
//             "${uDob!.year.toString().padLeft(4, '0')}-${uDob!.month.toString().padLeft(2, '0')}-${uDob!.day.toString().padLeft(2, '0')}",
//         "u_curr_age": uCurrAge,
//         "u_gender": uGender,
//         "u_image": uImage,
//         "u_profession": uProfession,
//         "u_state": uState,
//         "u_district": uDistrict,
//         "u_pincode": uPincode,
//         "u_first_log": uFirstLog,
//         "status": status,
//         "wallet_balance": walletBalance,
//         "u_bank_acc_no": uBankAccNo,
//         "u_ifsc": uIfsc,
//         "u_upi": uUpi,
//         "referred_by": referredBy,
//       };
// }
