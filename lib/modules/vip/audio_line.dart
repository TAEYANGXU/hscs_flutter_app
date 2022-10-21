
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hscs_flutter_app/modules/vip/view/audio_line_list.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'service.dart';
import 'view/vip_article_list.dart';
import 'view/audio_line_haeder.dart';

class VipAudioLinePage extends StatefulWidget
{
  int? actId;
  VipAudioLinePage({Key? key, this.actId}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipAudioLinePageState();
  }
}

class _VipAudioLinePageState extends State<VipAudioLinePage>
{

  final viewModel = VipViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  Future fetchData() async {
    await viewModel.getAudioDetail({"actId":widget.actId});
    await viewModel.getAudioActList({"actId":widget.actId,"page":1 ,"pageSize": 20});
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
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
                child: loadLocalImage("vip/vip_white_back",
                    width: Adapt.px(12), height: Adapt.px(22)),
              ),
              actions: [
                MaterialButton(
                  onPressed: () {

                  },
                  child: loadLocalImage("vip/vip_white_share",
                      width: Adapt.px(22), height: Adapt.px(22)),
                )],
              expandedHeight: Adapt.px(245),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(""),
                background: AudioLineHeaderView(actInfoData: viewModel.actInfo,),
              ),
            ),
          ];
        },
        body: SizedBox(
            child: viewModel.audioList!.isNotEmpty ? AudioLineListView(audioList: viewModel.audioList,) : Container()
        ),
      ),
    );
  }
}