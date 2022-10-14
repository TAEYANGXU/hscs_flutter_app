import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'model/index.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
import 'package:hscs_flutter_app/modules/home/model/home_ad.dart';
import 'package:hscs_flutter_app/modules/home/model/home_headline.dart';

class VipRecommendViewModel{

  List<IconList> iconList = [];
  List<TableData> tableList = [];
  List<AdvertListData> repostList = [];
  AudioList? audio;
  LiveVideoData? liveData;
  List<ListData>? columnList = [];

  ///九宫格
  Future getVipIconList() async {
    var model = await DioManagerUtils.get("/v3/vip-center/icon-list",params: {"tableId":1});
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
  Future getAudioActList() async {
    var model = await DioManagerUtils.getT<AudioData>("/v3/audio-tingting/list-with-act",params: {"page":1,"pageSize":1});
    print('length = ${model.data!.list!.length}');
    if(model.data!.list!.length > 0){
      audio = model.data!.list![0];
    }
  }

  /// 直播周课
  Future getLiveActList() async {
    var model = await DioManagerUtils.get("/v3/room/act-list",params: {"type":8});
    List list = model.data;
    var array = list.map((item) => LiveVideoData.fromJson(item)).toList();
    // print('length = ${model.data!.list!.length}');
    if(array.length > 0){
      print("live list = ${array.length}");
      liveData = array[0];
    }
  }

  /// 理财头条
  Future getColumnList() async {
    var model = await DioManagerUtils.get("/v3/column/list",params: {"type":1});
    List list = model.data["list"];
    var array = list.map((item) => ListData.fromJson(item)).toList();
    if(array.length > 0) {
      columnList = array;
      print("columnList list = ${array.length}");
    }
  }
}