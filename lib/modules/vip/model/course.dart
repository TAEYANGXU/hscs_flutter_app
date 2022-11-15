
class CategoryData {
  int? categoryId;
  String? categoryTitle;
  List<CourseList>? list = [];

  CategoryData({this.categoryId, this.categoryTitle, this.list});

  CategoryData.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    categoryTitle = json['categoryTitle'];
    if (json['list'] != null) {
      list = <CourseList>[];
      json['list'].forEach((v) {
        list!.add(new CourseList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['categoryTitle'] = this.categoryTitle;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CourseList {
  int? courseId;
  String? courseTitle;
  String? coverImage;
  String? description;
  bool? haveAccess;
  String? noAccessLink;

  CourseList(
      {this.courseId,
        this.courseTitle,
        this.coverImage,
        this.description,
        this.haveAccess,
        this.noAccessLink});

  CourseList.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseTitle = json['courseTitle'];
    coverImage = json['coverImage'];
    description = json['description'];
    haveAccess = json['haveAccess'];
    noAccessLink = json['noAccessLink'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['courseTitle'] = this.courseTitle;
    data['coverImage'] = this.coverImage;
    data['description'] = this.description;
    data['haveAccess'] = this.haveAccess;
    data['noAccessLink'] = this.noAccessLink;
    return data;
  }
}