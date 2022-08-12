import 'package:hscs_flutter_app/api/dio_manager.dart';
import 'package:hscs_flutter_app/modules/home/model/index.dart';
class HomeViewModel {
  AdvertListData?  listData;
  Future getAD() async {
    var model = await DioManagerUtils.get("/v3/advert/list-by-type",params: {"type":58});
    List list = model.data;
    var array = list.map((item) => AdvertListData.fromJson(item)).toList();
    if(array.isNotEmpty){
      listData = array[0];
    }
  }
}