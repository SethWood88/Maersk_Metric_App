class AllAPIModel {
  int? chkRespId;
  int? id;
  String? name;
  String? status;
  String? alertNote;
  String? location;
  int? monitoringInterval;
  int? requestTimeout;
  String? basicAuthUsername;
  String? basicAuthPassword;
  String? createdatetime;
  int? sequence;
  String? clientName;
  int? dBStatus;
  int? objStatus;
  String? resultCode;
  String? errorMessage;
  int? executionMS;

  AllAPIModel({this.chkRespId, this.id, this.name, this.status, this.alertNote, this.location, this.monitoringInterval, this.requestTimeout, this.basicAuthUsername, this.basicAuthPassword, this.createdatetime, this.sequence, this.clientName, this.dBStatus, this.objStatus, this.resultCode, this.errorMessage, this.executionMS});

  AllAPIModel.fromJson(Map<String, dynamic> json) {
    chkRespId = json['ChkRespId'];
    id = json['id'];
    name = json['name'];
    status = json['status'];
    alertNote = json['alert_note'];
    location = json['location'];
    monitoringInterval = json['monitoring_interval'];
    requestTimeout = json['request_timeout'];
    basicAuthUsername = json['basic_auth_username'];
    basicAuthPassword = json['basic_auth_password'];
    createdatetime = json['createdatetime'];
    sequence = json['sequence'];
    clientName = json['ClientName'];
    dBStatus = json['DBStatus'];
    objStatus = json['ObjStatus'];
    resultCode = json['ResultCode'];
    errorMessage = json['ErrorMessage'];
    executionMS = json['ExecutionMS'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ChkRespId'] = this.chkRespId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['alert_note'] = this.alertNote;
    data['location'] = this.location;
    data['monitoring_interval'] = this.monitoringInterval;
    data['request_timeout'] = this.requestTimeout;
    data['basic_auth_username'] = this.basicAuthUsername;
    data['basic_auth_password'] = this.basicAuthPassword;
    data['createdatetime'] = this.createdatetime;
    data['sequence'] = this.sequence;
    data['ClientName'] = this.clientName;
    data['DBStatus'] = this.dBStatus;
    data['ObjStatus'] = this.objStatus;
    data['ResultCode'] = this.resultCode;
    data['ErrorMessage'] = this.errorMessage;
    data['ExecutionMS'] = this.executionMS;

    return data;
  }
}


