
class ArticleData {
  int? id;
  String? title;
  String? summary;
  String? pdf;
  int? viewNum;
  String? cTime;
  bool? isRecommend;
  String? coverPic;
  String? linkUrl;
  String? author;
  bool? canExperience;
  String? h5Url;
  bool? canVisit;

  ArticleData(
      {this.id,
        this.title,
        this.summary,
        this.pdf,
        this.viewNum,
        this.cTime,
        this.isRecommend,
        this.coverPic,
        this.linkUrl,
        this.author,
        this.canExperience,
        this.h5Url,
        this.canVisit});

  ArticleData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    summary = json['summary'];
    pdf = json['pdf'];
    viewNum = json['viewNum'];
    cTime = json['cTime'];
    isRecommend = json['isRecommend'];
    coverPic = json['coverPic'];
    linkUrl = json['linkUrl'];
    author = json['author'];
    canExperience = json['canExperience'];
    h5Url = json['h5Url'];
    canVisit = json['canVisit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['summary'] = this.summary;
    data['pdf'] = this.pdf;
    data['viewNum'] = this.viewNum;
    data['cTime'] = this.cTime;
    data['isRecommend'] = this.isRecommend;
    data['coverPic'] = this.coverPic;
    data['linkUrl'] = this.linkUrl;
    data['author'] = this.author;
    data['canExperience'] = this.canExperience;
    data['h5Url'] = this.h5Url;
    data['canVisit'] = this.canVisit;
    return data;
  }
}