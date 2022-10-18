import 'model/index.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';

class HomeViewModel
{
  HomeData?  homeData;
  FundData?  fundData;
  HeadLineData? headLineData;
  List<ListData>? headLineTopList = [];
  List<ListData>? headLineList = [];
  AdvertListData? adData;
  List<VideoList>  videoList = [];

  Future<HomeData> getHomeData() async {
    var model = await DioManagerUtils.getT<HomeData>("/v3/home/index2");
    homeData = model.data;
    var vipH5Url =  homeData!.vipH5Url;
    var myAssetsUrl =  homeData!.myAssetsUrl;
    print("vipH5Url = $vipH5Url");
    print("myAssetsUrl = $myAssetsUrl");
    return homeData!;
  }

  Future<FundData> getFundData() async {
    var model = await DioManagerUtils.getT<FundData>("/v3/fund/fund-list");
    fundData = model.data;
    print("fundList = ${fundData!.fundList!.length}");
    return fundData!;
  }

  Future<HeadLineData> getHeadlineTop() async {
    var model = await DioManagerUtils.getT<HeadLineData>("/v3/headline/top");
    headLineData = model.data;
    if(headLineData!.list!.isNotEmpty){
      headLineTopList = headLineData!.list!;
    }
    return headLineData!;
  }

  Future getHeadlineList(Map<String,dynamic>? params) async {
    var model = await DioManagerUtils.get("/v3/headline/list",params: params);
    Map<String,dynamic> data = model.data;
    List list = data["list"];
    var array = list.map((item) => ListData.fromJson(item)).toList();
    if(array.isNotEmpty){
      headLineList = array;
      print("getHeadlineList = ${array.length}");
    }
  }

  Future getAD(Map<String,dynamic>? params) async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",params: params);
    List list = model.data;
    var array = list.map((item) => AdvertListData.fromJson(item)).toList();
    if(array.isNotEmpty){
      adData = array[0];
    }
  }

  Future getVideoListByType(Map<String,dynamic> params) async {
    var model = await DioManagerUtils.get("/v3/video/list-by-act-type",params: params);
    Map<String,dynamic> data = model.data;
    List list = data["list"];
    var array = list.map((item) => VideoList.fromJson(item)).toList();
    if(array.isNotEmpty){
      videoList = array;
      print("length = ${array.length}");
    }
  }

}