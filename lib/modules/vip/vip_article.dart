
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'service.dart';
import 'view/vip_article_header.dart';
import 'view/vip_article_list.dart';

class VipArticlePage extends StatefulWidget
{
  int? articleType;
  VipArticlePage({Key? key, this.articleType}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _VipArticlePageState();
  }
}

class _VipArticlePageState extends State<VipArticlePage>
{

  final viewModel = VipViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getPDFList({"articleType":widget.articleType,"page":1 ,"pageSize": 20});
    setState(() {});
  }

  Widget _cellForRow(BuildContext context, int index) {
    var model = viewModel.vipArticleData!.list![index];
    return GestureDetector(
      onTap: (){

      },
      child: Container(),
    );
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
              expandedHeight: Adapt.px(235),
              floating: true,
              pinned: false,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: const Text(""),
                background: viewModel.vipArticleData != null ? VipArticleHeaderView(articleData: viewModel.vipArticleData,) : Container(),
              ),
            ),
          ];
        },
        body: SizedBox(
          child: viewModel.vipArticleData != null ? VipArticleView(articleList: viewModel.vipArticleData!.list,) : Container()
        ),
      ),
    );
  }
}