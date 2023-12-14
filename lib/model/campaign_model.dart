class CampaignModel {
  String? message;
  bool? status;
  List<CampaignData>? data;

  CampaignModel({
    this.message,
    this.status,
    this.data,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) => CampaignModel(
        message: json["message"],
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<CampaignData>.from(
                json["data"]!.map((x) => CampaignData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class CampaignData {
  int? campId;
  String? campName;
  String? campType;
  DateTime? campStart;
  DateTime? campEnd;
  String? campFile;

  CampaignData({
    this.campId,
    this.campName,
    this.campType,
    this.campStart,
    this.campEnd,
    this.campFile,
  });

  factory CampaignData.fromJson(Map<String, dynamic> json) => CampaignData(
        campId: json["camp_id"],
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
        "camp_id": campId,
        "camp_name": campName,
        "camp_type": campType,
        "camp_start":
            "${campStart!.year.toString().padLeft(4, '0')}-${campStart!.month.toString().padLeft(2, '0')}-${campStart!.day.toString().padLeft(2, '0')}",
        "camp_end":
            "${campEnd!.year.toString().padLeft(4, '0')}-${campEnd!.month.toString().padLeft(2, '0')}-${campEnd!.day.toString().padLeft(2, '0')}",
        "camp_file": campFile,
      };
}
