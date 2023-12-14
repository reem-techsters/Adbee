// class GetTicketDetails {
//   String? message;
//   bool? status;
//   List<TicketDetailsDatum>? data;

//   GetTicketDetails({
//     this.message,
//     this.status,
//     this.data,
//   });

//   factory GetTicketDetails.fromJson(Map<String, dynamic> json) =>
//       GetTicketDetails(
//         message: json["message"],
//         status: json["status"],
//         data: json["data"] == null
//             ? []
//             : List<TicketDetailsDatum>.from(
//                 json["data"]!.map((x) => TicketDetailsDatum.fromJson(x))),
//       );

//   Map<String, dynamic> toJson() => {
//         "message": message,
//         "status": status,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//       };
// }

// class TicketDetailsDatum {
//   String? subject;
//   String? query;
//   int? isReplyEnable;
//   String? createdTimestamp;
//   dynamic ticketID;

//   TicketDetailsDatum({
//     this.subject,
//     this.query,
//     this.isReplyEnable,
//     this.createdTimestamp,
//     this.ticketID,
//   });

//   factory TicketDetailsDatum.fromJson(Map<String, dynamic> json) =>
//       TicketDetailsDatum(
//         subject: json["subject"],
//         query: json["query"],
//         isReplyEnable: json["is_reply_enable"],
//         createdTimestamp: json["created_timestamp"],
//         ticketID: json["ticket_id"],
//       );

//   Map<String, dynamic> toJson() => {
//         "subject": subject,
//         "query": query,
//         "ticketID": ticketID,
//         "is_reply_enable": isReplyEnable,
//         "created_timestamp": createdTimestamp,
//       };
// }
