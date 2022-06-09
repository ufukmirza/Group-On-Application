class AddActivityModel {
  String? userUid;
  String? activityName;
  String? userName;
  String? activityDeclarition;
  String? activityLocation;
  List<String>? activityTypes;
  int? activityUserLimit;
  String? activityTime;
  String? imageUrl;
  String? activityUid;

  AddActivityModel(
      {this.userUid,
      this.activityName,
      this.userName,
      this.activityDeclarition,
      this.activityLocation,
      this.activityTime,
      this.activityUserLimit,
      this.activityTypes,
      this.imageUrl,
      this.activityUid});
  AddActivityModel.fromJson(Map<String, dynamic> json) {
    userUid = json['userUid'];
    activityName = json['activityName'];
    userName = json['userName'];
    activityDeclarition = json['activityDeclarition'];
    activityLocation = json['activityLocation'];
    activityTypes = json['activityTypes'].cast<String>();
    activityUserLimit = json['activityUserLimit'];
    activityTime = json['activityTime'];
    imageUrl = json['imageUrl'];
    activityUid = json['activityUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUid'] = this.userUid;
    data['activityName'] = this.activityName;
    data['userName'] = this.userName;
    data['activityDeclarition'] = this.activityDeclarition;
    data['activityLocation'] = this.activityLocation;
    data['activityTypes'] = this.activityTypes;
    data['activityUserLimit'] = this.activityUserLimit;
    data['activityTime'] = this.activityTime;
    data['imageUrl'] = this.imageUrl;
    data['activityUid'] = this.activityUid;
    return data;
  }
}
