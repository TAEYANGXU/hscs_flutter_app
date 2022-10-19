
import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';
import 'service.dart';
import 'view/teacher_header.dart';
import 'view/master_article.dart';

class MasterDetailPage extends StatefulWidget
{
  MasterDetailPage({Key? key,this.teacherId}) : super(key: key);

  int? teacherId;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MasterDetailPageState();
  }
}

class _MasterDetailPageState extends State<MasterDetailPage> {
  var tabTitle = [
    '文章',
    '直播贴',
  ];

  final viewModel = HomeViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    await viewModel.getTeacherDetail({"id":widget.teacherId!});
    await viewModel.getArticleByTeacher({"teacherId":widget.teacherId!,"isChief":false,"page":1,"pageSize":20});
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: tabTitle.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          body:  NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.white,
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: loadLocalImage("home/master_back",
                        width: Adapt.px(12), height: Adapt.px(22)),
                  ),
                  expandedHeight: Adapt.px(210),
                  floating: true,
                  pinned: false,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: const Text(""),
                      background: TeacherHeaderView(teacherData: viewModel.teacherData,),
                  ),
                ),
                 SliverPersistentHeader(
                  delegate: SliverTabBarDelegate(
                    TabBar(
                      tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                      //未选择样式
                      unselectedLabelStyle: const TextStyle(fontSize: TextSize.larger),
                      //选择样式
                      labelStyle: const TextStyle(
                          fontSize: TextSize.larger),
                      //选中的颜色
                      labelColor: AppColors.theme,
                      //未选中的颜色
                      unselectedLabelColor: AppColors.text,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: AppColors.theme,
                    ),
                    color: Colors.white,
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              children: [
                viewModel.articleList!.isNotEmpty ? TeacherArticleView(articleList: viewModel.articleList,) : Container(),
                Container(),
              ],
            ),
          ),
        )
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {required this.color}) : assert(widget != null);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}