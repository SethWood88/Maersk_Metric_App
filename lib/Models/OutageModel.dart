class OutageModel {
  int? id;
  String? outageId;
  int? freshpingid;
  int? duration;
  String? ticketnumber;
  String? createdDateTime;
  String? detectedDateTime;
  String? resolvedDateTime;
  String? clientName;
  int? dBStatus;
  int? objStatus;
  String? resultCode;
  String? errorMessage;
  int? executionMS;

  OutageModel(
      {this.id,
      this.outageId,
      this.freshpingid,
      this.duration,
      this.ticketnumber,
      this.createdDateTime,
      this.detectedDateTime,
      this.resolvedDateTime,
      this.clientName,
      this.dBStatus,
      this.objStatus,
      this.resultCode,
      this.errorMessage,
      this.executionMS});

  static List<OutageModel>? fromArrayJson(List<dynamic> json) =>
      json.map((e) => OutageModel.fromJson(e)).toList();

  OutageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    outageId = json['outageId'];
    freshpingid = json['freshpingid'];
    duration = json['duration'];
    ticketnumber = json['ticketnumber'];
    createdDateTime = json['createdDateTime'];
    detectedDateTime = json['detectedDateTime'];
    resolvedDateTime = json['resolvedDateTime'];
    clientName = json['ClientName'];
    dBStatus = json['DBStatus'];
    objStatus = json['ObjStatus'];
    resultCode = json['ResultCode'];
    errorMessage = json['ErrorMessage'];
    executionMS = json['ExecutionMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['outageId'] = this.outageId;
    data['freshpingid'] = this.freshpingid;
    data['duration'] = this.duration;
    data['ticketnumber'] = this.ticketnumber;
    data['createdDateTime'] = this.createdDateTime;
    data['detectedDateTime'] = this.detectedDateTime;
    data['resolvedDateTime'] = this.resolvedDateTime;
    data['ClientName'] = this.clientName;
    data['DBStatus'] = this.dBStatus;
    data['ObjStatus'] = this.objStatus;
    data['ResultCode'] = this.resultCode;
    data['ErrorMessage'] = this.errorMessage;
    data['ExecutionMS'] = this.executionMS;
    return data;
  }
}
