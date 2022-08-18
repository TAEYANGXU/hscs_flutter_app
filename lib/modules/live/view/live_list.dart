import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/index.dart';
import '../cell/livelist.dart';

class LiveListPage extends StatefulWidget{

  LiveListPage({Key? key,this.liveList}) : super(key: key);
  List<LiveList>? liveList;
  @override
  _LiveListPageState createState() => _LiveListPageState();
}

class _LiveListPageState extends State<LiveListPage> {

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      if(widget.liveList!.length > 0){
        // if(_controller.offset == _controller.position.maxScrollExtent){
        //   return;
        // }
        _controller.jumpTo(_controller.position.maxScrollExtent);
        // _controller.animateTo(_controller.position.maxScrollExtent, duration: const Duration(milliseconds: 20), curve: Curves.linear);
      }
    });
  }

  Widget _cellForRow(BuildContext context,int index){

    if(widget.liveList!.length == index){
      return Container(
        padding: EdgeInsets.only(left: Adapt.px(60),right: Adapt.px(40),bottom: Adapt.px(20)),
        child: Text("本界面内容及分析仅供您参考学习，不构成对任何金融产品的投资建议，投资有风险，入市需谨慎！",style: TextStyle(color: AppColors.gredText),),
      );
    }
    var model = widget.liveList![index];
    if(int.parse(model.liveMsg!.type!) == 0){
      // print("liveMsg-summary ${model.liveMsg?.richContent}");
      // print("liveMsg-pics ${model.liveMsg?.pics!.length}");
      return LiveListCell(model: model,);
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: ListView.builder(itemBuilder: _cellForRow,
      controller: _controller,
      itemCount: widget.liveList != null ?  widget.liveList!.length  + 1 : 0,
      // physics: BouncingScrollPhysics(),
      ),
    );
  }
}