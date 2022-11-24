import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'model/index.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';

class VipViewModel{

  List<IconList> iconList = [];
  List<TableData> tableList = [];
  List<AdvertListData> repostList = [];
  AudioList? audio;
  LiveVideoData? liveData;
  List<ListData>? columnList = [];
  List<ListData>? moreColumnList = [];
  VipArticleData? vipArticleData;
  ActInfoData? actInfo;
  List<AudioList>? audioList = [];
  List<BackReviewList>? backReviewList = [];
  List<CategoryData>? categoryList = [];
  List<VipArticleList>? articleList = [];

  ///九宫格
  Future getVipIconList(Map<String,dynamic> params) async {
    var model = await DioManagerUtils.get("/v3/vip-center/icon-list",params: params);
    List list = model.data;
    var array = list.map((item) => IconList.fromJson(item)).toList();
    if(array.isNotEmpty){
      print("icon list = ${array.length}");
      iconList = array;
    }
  }

  ///
  Future getVipTopTableList() async {
    var model = await DioManagerUtils.get("/v3/vip-center/top-table-list");
    List list = model.data;
    var array = list.map((e) => TableData.fromJson(e)).toList();
    if(array.isNotEmpty){
      print("table list = ${array.length}");
      tableList = array;
    }
  }

  ///花生精选
  Future getReportList() async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",params: {"type":56});
    List list = model.data;
    var array = list.map((item) => AdvertListData.fromJson(item)).toList();
    if(array.isNotEmpty){
      repostList = array;
    }
  }

  ///音频列表
  Future getAudioActList(Map<String, dynamic> params) async {
    var model = await DioManagerUtils.getT<AudioData>("/v3/audio-tingting/list-with-act",params: params);
    print('length = ${model.data!.list!.length}');
    if(model.data!.list!.isNotEmpty){
      audio = model.data!.list![0];
      audioList?.addAll(model.data!.list!);
    }
  }

  /// 直播周课
  Future getLiveActList() async {
    var model = await DioManagerUtils.get("/v3/room/act-list",params: {"type":8});
    List list = model.data;
    var array = list.map((item) => LiveVideoData.fromJson(item)).toList();
    // print('length = ${model.data!.list!.length}');
    if(array.isNotEmpty){
      print("live list = ${array.length}");
      liveData = array[0];
      await getReviewActList({"roomId":liveData!.roomId});
    }
  }

  /// 理财头条
  Future getColumnList(Map<String,dynamic> param) async {
    var model = await DioManagerUtils.get("/v3/column/list",params: param);
    List list = model.data["list"];
    var array = list.map((item) => ListData.fromJson(item)).toList();
    if(array.isNotEmpty) {
      columnList = array;
      print("columnList list = ${array.length}");
    }
  }

  Future getColumnList2(Map<String,dynamic> param) async {
    var model = await DioManagerUtils.get("/v3/column/list",params: param);
    List list = model.data["list"];
    var array = list.map((item) => ListData.fromJson(item)).toList();
    if(array.isNotEmpty) {
      moreColumnList?.addAll(array);
      print("columnList list = ${array.length}");
    }
  }

  /// 获取PDF类文章列表
  Future getPDFList(Map<String,dynamic>? param) async {
    var model = await DioManagerUtils.get("/v3/article/get-pdf-list",params: param);
    vipArticleData = VipArticleData.fromJson(model.data);
  }

  /// 音频节目详情
  Future getAudioDetail(Map<String,dynamic>? param) async {
    var model = await DioManagerUtils.get("/v3/audio-tingting/act-detail",params: param);
    actInfo = ActInfoData.fromJson(model.data);
  }


  ///  直播回放列表
  Future getReviewListByAct(Map<String,dynamic> params) async {
    var model = await DioManagerUtils.get("/v3/room/review-list-by-act",params: params);
    List list = model.data["list"];
    var array = list.map((item) => BackReviewList.fromJson(item)).toList();
    if(array.isNotEmpty) {
      backReviewList?.addAll(array);
      print("backReviewList list = ${array.length}");
    }
  }
  /// 直播回放节目列表
  Future getReviewActList(Map<String,dynamic> params) async {
    var model = await DioManagerUtils.get("/v3/room/review-act-list",params: params);
    // List list = model.data["list"];
    // var array = list.map((item) => ListData.fromJson(item)).toList();
    // if(array.length > 0) {
    //   columnList = array;
    //   print("columnList list = ${array.length}");
    // }
  }

  ///  所有课程
  Future getVideoCourseList(Map<String,dynamic> params) async {
    var model = await DioManagerUtils.get("/v3/video-course/center-list",params: params);
    List list = model.data;
    var array = list.map((item) => CategoryData.fromJson(item)).toList();
    if(array.isNotEmpty) {
      categoryList = array;
      print("categoryList list = ${array.length}");
    }
  }
  /// 获取独家报告列表
  Future getArticleAllList(Map<String,dynamic> params) async {
    var model = await DioManagerUtils.get("/v3/article/all-sort-list",params: params);
    List list = model.data;
    var array = list.map((item) => VipArticleList.fromJson(item)).toList();
    if(array.isNotEmpty) {
      articleList?.addAll(array);
      print("articleList list = ${array.length}");
    }
  }
}