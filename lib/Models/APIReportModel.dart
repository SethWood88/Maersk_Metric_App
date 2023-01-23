class APIReportModel {
  String? checkname;
  int? freshpingid;
  String? totalUptime;
  int? totalEntries;
  String? overallTimespan;
  int? monitoringInterval;
  String? totalDowntime;
  double? totalUptimePercent;
  double? totalDowntimePercent;
  double? averageOutageDuration;
  String? clientName;
  int? dBStatus;
  int? objStatus;
  String? resultCode;
  String? errorMessage;
  int? executionMS;

  APIReportModel(
      {this.checkname,
      this.freshpingid,
      this.totalUptime,
      this.totalEntries,
      this.overallTimespan,
      this.monitoringInterval,
      this.totalDowntime,
      this.totalUptimePercent,
      this.totalDowntimePercent,
      this.averageOutageDuration,
      this.clientName,
      this.dBStatus,
      this.objStatus,
      this.resultCode,
      this.errorMessage,
      this.executionMS});

  static List<APIReportModel>? fromArrayJson(List<dynamic> json) =>
      json.map((e) => APIReportModel.fromJson(e)).toList();

  APIReportModel.fromJson(Map<String, dynamic> json) {
    checkname = json['checkname'];
    freshpingid = json['freshpingid'];
    totalUptime = json['TotalUptime'];
    totalEntries = json['TotalEntries'];
    overallTimespan = json['OverallTimespan'];
    monitoringInterval = json['monitoring_interval'];
    totalDowntime = json['TotalDowntime'];
    totalUptimePercent = json['totalUptimePercent'];
    totalDowntimePercent = json['totalDowntimePercent'];
    averageOutageDuration = json['averageOutageDuration'];
    clientName = json['ClientName'];
    dBStatus = json['DBStatus'];
    objStatus = json['ObjStatus'];
    resultCode = json['ResultCode'];
    errorMessage = json['ErrorMessage'];
    executionMS = json['ExecutionMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkname'] = this.checkname;
    data['freshpingid'] = this.freshpingid;
    data['TotalUptime'] = this.totalUptime;
    data['TotalEntries'] = this.totalEntries;
    data['OverallTimespan'] = this.overallTimespan;
    data['monitoring_interval'] = this.monitoringInterval;
    data['TotalDowntime'] = this.totalDowntime;
    data['totalUptimePercent'] = this.totalUptimePercent;
    data['totalDowntimePercent'] = this.totalDowntimePercent;
    data['averageOutageDuration'] = this.averageOutageDuration;
    data['ClientName'] = this.clientName;
    data['DBStatus'] = this.dBStatus;
    data['ObjStatus'] = this.objStatus;
    data['ResultCode'] = this.resultCode;
    data['ErrorMessage'] = this.errorMessage;
    data['ExecutionMS'] = this.executionMS;
    return data;
  }
}
