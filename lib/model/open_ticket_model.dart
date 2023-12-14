class OpenTicketModel {
  String? message;
  bool? status;
  List<OpenTDatum>? data;

  OpenTicketModel({
    this.message,
    this.status,
    this.data,
  });

  factory OpenTicketModel.fromJson(Map<String, dynamic> json) =>
      OpenTicketModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<OpenTDatum>.from(
                json["data"]!.map((x) => OpenTDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class OpenTDatum {
  int? ticketId;
  int? uId;
  String? subject;
  String? query;
  int? isReplyEnable;
  dynamic repliedBy;
  int? threadId;
  int? isReplied;
  String? currentStatus;
  String? createdTimestamp;
  int? uMobno;
  String? uName;
  String? uEmail;

  OpenTDatum({
    this.ticketId,
    this.uId,
    this.subject,
    this.query,
    this.isReplyEnable,
    this.repliedBy,
    this.threadId,
    this.isReplied,
    this.currentStatus,
    this.createdTimestamp,
    this.uMobno,
    this.uName,
    this.uEmail,
  });

  factory OpenTDatum.fromJson(Map<String, dynamic> json) => OpenTDatum(
        ticketId: json["ticket_id"],
        uId: json["u_id"],
        subject: json["subject"],
        query: json["query"],
        isReplyEnable: json["is_reply_enable"],
        repliedBy: json["replied_by"],
        threadId: json["thread_id"],
        isReplied: json["is_replied"],
        currentStatus: json["current_status"],
        createdTimestamp: json["created_timestamp"],
        uMobno: json["u_mobno"],
        uName: json["u_name"],
        uEmail: json["u_email"],
      );

  Map<String, dynamic> toJson() => {
        "ticket_id": ticketId,
        "u_id": uId,
        "subject": subject,
        "query": query,
        "is_reply_enable": isReplyEnable,
        "replied_by": repliedBy,
        "thread_id": threadId,
        "is_replied": isReplied,
        "current_status": currentStatus,
        "created_timestamp": createdTimestamp,
        "u_mobno": uMobno,
        "u_name": uName,
        "u_email": uEmail,
      };
}
