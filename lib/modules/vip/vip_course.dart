import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/vip/service.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import '../home/view/sudoku.dart';
import 'view/index.dart';
import 'model/index.dart';
import 'package:hscs_flutter_app/style/index.dart';

class VipCourcePage extends StatefulWidget
{
  const VipCourcePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipCourcePageState();
  }

}

class _VipCourcePageState extends State<VipCourcePage> {

  var viewModel = VipViewModel();

  @override
  void initState(){
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getVipIconList({"tableId":4});
    await viewModel.getVideoCourseList({});
    setState(() {});
  }

  List<Widget> getVipCourse(List<CategoryData> list) {

    if(list.isEmpty){
      return [];
    }
    List<Widget> items = [];
    for(int i=0;i<list.length;i++){
      CategoryData data = list[i];
      items.add(VipCourseView(categoryData: data,));
    }
    return items;

    return [];
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(0),
        child: Column(
          children: [
            HomeSudokuView(iconList: viewModel.iconList),
            Container(
              color: AppColors.line,
              width: double.infinity,
              height: Adapt.px(8),
            ),
            SizedBox(height: Adapt.px(10),),
            viewModel.categoryList!.isNotEmpty ? Column(
              children: getVipCourse(viewModel.categoryList!),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
