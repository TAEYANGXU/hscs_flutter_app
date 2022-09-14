import 'model/index.dart';
import 'package:hscs_flutter_app/api/dio_manager.dart';

class HomeViewModel
{
  HomeData?  homeData;
  FundData?  fundData;
  HeadLineData? headLineData;
  late AdvertListData listData;

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
    return fundData!;
  }

  Future<HeadLineData> getHeadlineTop() async {
    var model = await DioManagerUtils.getT<HeadLineData>("/v3/headline/top");
    headLineData = model.data;
    return headLineData!;
  }

  Future getBottomAD() async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",params: {"type":22});
    List list = model.data;
    var array = list.map((item) => AdvertListData.fromJson(item)).toList();
    if(array.isNotEmpty){
      listData = array[0];
    }
  }
}