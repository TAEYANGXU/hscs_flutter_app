import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'service.dart';
import 'view/search_bar.dart';
import 'package:hscs_flutter_app/extension/loading_icon.dart';

class LiveSearchPage extends StatefulWidget {
  LiveSearchPage({Key? key,this.roomId}) : super(key: key);
  int? roomId;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LiveSearchPageState();
  }
}

class _LiveSearchPageState extends State<LiveSearchPage> {
  final viewModel = LiveViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  Future searchChat(String text) async {
    viewModel.requestRoomSearchList({"keyword":text,"roomId":widget.roomId});
    setState(() {

    });
  }

  Widget _cellForRow(BuildContext context, int index) {
    if (index == 0 ){
      return Container(
        height: Adapt.px(40),
        margin: EdgeInsets.only(left: Adapt.px(15),top: Adapt.px(10)),
        child: const Text("直播互动",style: TextStyle(fontSize: TextSize.big),),
      );
    }
    if(viewModel.searchList.isEmpty){
      return Container();
    }
    if(index >= viewModel.searchList.length){
      return Container();
    }
    var model = viewModel.searchList[index];
    return  Container(
      height: Adapt.px(60),
      width: double.infinity,
      child: Stack(
        children: [
          Positioned(
            top: Adapt.px(0),
            left: Adapt.px(15),
            child: Container(
              width: Adapt.screenW() - Adapt.px(15),
              height: Adapt.px(1),
              color: AppColors.line,
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: Adapt.px(15)),
                  width: Adapt.px(40),
                  height: Adapt.px(40),
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(Adapt.px(20))
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CacheImage(imageUrl: model.avatar,),
                ),
                Container(
                  margin: EdgeInsets.only(left: Adapt.px(10)),
                  width: Adapt.screenW() - Adapt.px(90),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Adapt.px(5),),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(model.nickname ?? "",style: TextStyle(fontSize: TextSize.larger,fontWeight: FontWeight.bold),),
                          Text(model.createdAt ?? "",style: TextStyle(fontSize: TextSize.small,color: AppColors.gredText),),
                        ],
                      ),
                      SizedBox(height: Adapt.px(5),),
                      Container(
                        child: Text(model.content ?? "",style: const TextStyle(fontSize: TextSize.main,overflow: TextOverflow.ellipsis),maxLines: 1),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            bottom: Adapt.px(0),
            left: Adapt.px(15),
            child: Container(
              width: Adapt.screenW() - Adapt.px(15),
              height: Adapt.px(1),
              color: AppColors.line,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      body: NestedScrollView(
        headerSliverBuilder: (context, bool) {
          return [
            SliverAppBar(
              backgroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },

                ///
                child: Container(),
              ),

              expandedHeight: Adapt.px(50),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(""),
                background: SearchBarView(onChanged: (text) async {
                  print("text ----- ${text}");
                  searchChat(text);
                },),
              ),
            ),
          ];
        },
        body: SizedBox(child: Container(
          child: ListView.builder(itemBuilder: _cellForRow,
          itemCount: viewModel.searchList.length + 1,
          padding: EdgeInsets.zero,),
        )),
      ),
    );
  }
}
