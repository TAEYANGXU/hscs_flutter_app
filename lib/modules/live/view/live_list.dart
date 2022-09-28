import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import '../model/index.dart';
import '../cell/livelist.dart';
import 'package:hscs_flutter_app/utils/photos_view.dart';

class LiveListPage extends StatefulWidget{

  LiveListPage({Key? key,this.liveList,this.liveController,this.topList}) : super(key: key);
  List<LiveList>? liveList;
  List<LiveMsg>? topList;
  ScrollController? liveController = ScrollController();
  @override
  _LiveListPageState createState() => _LiveListPageState();
}

class _LiveListPageState extends State<LiveListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      if(widget.liveList!.length > 0){
        // if(_controller.offset == _controller.position.maxScrollExtent){
        //   return;
        // }
        widget.liveController!.jumpTo(widget.liveController!.position.maxScrollExtent);
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

  Widget _topCellForRow(BuildContext context,int index){
    var model = widget.topList![index];
    return Container(
      height: Adapt.px(30),
      width: double.infinity,
      color: index%2 == 0 ? Colors.yellow : Colors.blue,
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            height: Adapt.px(30),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: Adapt.px(15)),
                  decoration: BoxDecoration(
                      color: HexColor("#FFF5EF"),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(width: Adapt.px(0.5),color: HexColor("#FC6200"))
                  ),
                  width: Adapt.px(32),
                  height: Adapt.px(16),
                  child: Center(child: Text("置顶",textAlign: TextAlign.center,style: TextStyle(color: HexColor("#FC6200"),fontSize: TextSize.small),),),
                ),
                SizedBox(width: Adapt.px(5),),
                Container(
                  width: Adapt.screenW() - Adapt.px(110),
                  child: Center(
                    child: Text(model.summary!,style: TextStyle(color: AppColors.gredText),maxLines: 1,overflow: TextOverflow.ellipsis,),
                  ),
                ),
                SizedBox(width: Adapt.px(20),),
                Container(
                  child: Text("查看",style: TextStyle(color: Colors.blue),),
                )
              ],
            ),
          ),
          Container(
            color: AppColors.line,
            height: Adapt.px(1),
            margin: EdgeInsets.only(left: Adapt.px(15),right: Adapt.px(15),top: Adapt.px(29)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          child: ListView.builder(itemBuilder: _cellForRow,
            controller: widget.liveController,
            itemCount: widget.liveList != null ?  widget.liveList!.length  + 1 : 0,
            // physics: BouncingScrollPhysics(),
          ),
        ),
        Container(
          height: widget.topList != null ? widget.topList!.length * Adapt.px(30) : 0,
          width: double.infinity,
          color: Colors.white,
          child:
          ListView.builder(itemBuilder: _topCellForRow,
            itemCount: widget.topList != null ? widget.topList!.length : 0,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }
}