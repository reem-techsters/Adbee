class TransactionsModel {
  String? message;
  bool? status;
  List<TransactionsDatum>? data;

  TransactionsModel({
    this.message,
    this.status,
    this.data,
  });

  factory TransactionsModel.fromJson(Map<String, dynamic> json) =>
      TransactionsModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<TransactionsDatum>.from(
                json["data"]!.map((x) => TransactionsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TransactionsDatum {
  int? paymentLogId;
  int? amountCredited;
  int? amountDebited;
  int? uId;
  String? walletId;
  String? transDate;
  dynamic actionTakenBy;
  String? transStatus;
  dynamic transactionId;
  dynamic rejectReason;
  dynamic actionDate;
  int? amountRs;

  TransactionsDatum({
    this.paymentLogId,
    this.amountCredited,
    this.amountDebited,
    this.uId,
    this.walletId,
    this.transDate,
    this.actionTakenBy,
    this.transStatus,
    this.transactionId,
    this.rejectReason,
    this.actionDate,
    this.amountRs,
  });

  factory TransactionsDatum.fromJson(Map<String, dynamic> json) =>
      TransactionsDatum(
        paymentLogId: json["payment_log_id"],
        amountCredited: json["amount_credited"],
        amountDebited: json["amount_debited"],
        uId: json["u_id"],
        walletId: json["wallet_id"],
        transDate: json["trans_date"],
        actionTakenBy: json["action_taken_by"],
        transStatus: json["trans_status"],
        transactionId: json["transaction_id"],
        rejectReason: json["reject_reason"],
        actionDate: json["action_date"],
        amountRs: json["amount_rs"],
      );

  Map<String, dynamic> toJson() => {
        "payment_log_id": paymentLogId,
        "amount_credited": amountCredited,
        "amount_debited": amountDebited,
        "u_id": uId,
        "wallet_id": walletId,
        "trans_date": transDate,
        "action_taken_by": actionTakenBy,
        "trans_status": transStatus,
        "transaction_id": transactionId,
        "reject_reason": rejectReason,
        "action_date": actionDate,
        "amount_rs": amountRs,
      };
}
