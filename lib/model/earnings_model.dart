class EarningsModel {
  String? message;
  bool? status;
  List<EarningsDatum>? data;

  EarningsModel({
    this.message,
    this.status,
    this.data,
  });

  factory EarningsModel.fromJson(Map<String, dynamic> json) => EarningsModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<EarningsDatum>.from(
                json["data"]!.map((x) => EarningsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EarningsDatum {
  int? coins;
  int? campId;
  String? viewDate;
  String? campName;
  String? campType;
  DateTime? campStart;
  DateTime? campEnd;
  String? campFile;

  EarningsDatum({
    this.coins,
    this.campId,
    this.viewDate,
    this.campName,
    this.campType,
    this.campStart,
    this.campEnd,
    this.campFile,
  });

  factory EarningsDatum.fromJson(Map<String, dynamic> json) => EarningsDatum(
        coins: json["coins"],
        campId: json["camp_id"],
        viewDate: json["view_date"],
        campName: json["camp_name"],
        campType: json["camp_type"],
        campStart: json["camp_start"] == null
            ? null
            : DateTime.parse(json["camp_start"]),
        campEnd:
            json["camp_end"] == null ? null : DateTime.parse(json["camp_end"]),
        campFile: json["camp_file"],
      );

  Map<String, dynamic> toJson() => {
        "coins": coins,
        "camp_id": campId,
        "view_date": viewDate,
        "camp_name": campName,
        "camp_type": campType,
        "camp_start":
            "${campStart!.year.toString().padLeft(4, '0')}-${campStart!.month.toString().padLeft(2, '0')}-${campStart!.day.toString().padLeft(2, '0')}",
        "camp_end":
            "${campEnd!.year.toString().padLeft(4, '0')}-${campEnd!.month.toString().padLeft(2, '0')}-${campEnd!.day.toString().padLeft(2, '0')}",
        "camp_file": campFile,
      };
}
