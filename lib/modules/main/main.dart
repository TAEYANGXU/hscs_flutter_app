import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/modules/home/home.dart';
import 'package:hscs_flutter_app/modules/live/live.dart';
import 'package:hscs_flutter_app/modules/vip/vip.dart';
import 'package:hscs_flutter_app/modules/mine/mine.dart';
import 'package:hscs_flutter_app/style/index.dart';
import 'package:hscs_flutter_app/utils/index.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key,this.tabIndex = "0"}) : super(key: key);
  String? tabIndex;
  @override
  MainPageState  createState() => MainPageState();
}

class MainPageState extends State<MainPage>
{
  late PageController  _pageController;
  List<Map<String, dynamic>> tabList = [
    {'index':0,'name':"",'icon':AppIcons.tabHome,'activeIcon':AppIcons.tabHomeSelect},
    {'index':1,'name':"",'icon':AppIcons.tabLive,'activeIcon':AppIcons.tabLiveSelect},
    {'index':2,'name':"",'icon':AppIcons.tabVip,'activeIcon':AppIcons.tabVip},
    {'index':3,'name':"",'icon':AppIcons.tabMine,'activeIcon':AppIcons.tabMineSelect},
  ];
  var allPages = [new HomePage(),new LivePage(),new VipPage(),new MinePage()];

  @override
  void initState(){
    super.initState();
  }

  @override
  Future init() async {
     _pageController = PageController();
     setState(() {});
  }

  TextStyle textStyle(int index){
    return index == int.parse(widget.tabIndex!) ? AppTextStyle.moreTinyTheme : AppTextStyle.moreTiny;
  }

  void onTap(int index){
    setState(() {
      print("index22：$index");
      widget.tabIndex = '${index}';
    });
  }

  @override
  Widget build(BuildContext context){
    Adapt.init(context);
    return Scaffold(
      backgroundColor: AppColors.theme,
      body: allPages[int.parse(widget.tabIndex!)],
      bottomNavigationBar:BottomNavigationBar(
          unselectedItemColor: AppColors.tabText,
          selectedItemColor: widget.tabIndex == 2 ? HexColor("##E0B777") : AppColors.tabTextSelect,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: TextSize.moreTiny,
          unselectedFontSize: TextSize.moreTiny,
          currentIndex: int.parse(widget.tabIndex!),
          items: [
            BottomNavigationBarItem(icon: AppIcons.tabHome,label: '首页',activeIcon: AppIcons.tabHomeSelect,),
            BottomNavigationBarItem(icon: AppIcons.tabLive,label: '直播',activeIcon: AppIcons.tabLiveSelect,),
            BottomNavigationBarItem(icon: AppIcons.tabVip,label: '会员区',activeIcon: AppIcons.tabVipSelect,),
            BottomNavigationBarItem(icon: AppIcons.tabMine,label: '我的',activeIcon: AppIcons.tabMineSelect,),
      ],
        onTap: onTap,
      ),
    );
  }
}