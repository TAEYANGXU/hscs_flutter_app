
class SearchList {
  String? avatar;
  String? nickname;
  int? feedId;
  int? msgId;
  String? content;
  String? createdAt;

  SearchList(
      {this.avatar,
        this.nickname,
        this.feedId,
        this.msgId,
        this.content,
        this.createdAt
      });

  SearchList.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    nickname = json['nickname'];
    feedId = json['feedId'];
    msgId = json['msgId'];
    content = json['content'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avatar'] = this.avatar;
    data['nickname'] = this.nickname;
    data['feedId'] = this.feedId;
    data['msgId'] = this.msgId;
    data['content'] = this.content;
    data['createdAt'] = this.createdAt;
    return data;
  }
}