class RoomInfo {
  int? roomId;
  bool? isDefault;
  String? roomName;

  RoomInfo({this.roomId, this.isDefault, this.roomName});

  RoomInfo.fromJson(Map<String, dynamic> json) {
    roomId = json['roomId'];
    isDefault = json['isDefault'];
    roomName = json['roomName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomId'] = this.roomId;
    data['isDefault'] = this.isDefault;
    data['roomName'] = this.roomName;
    return data;
  }
}