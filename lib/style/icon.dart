import 'package:flutter/material.dart';
import 'package:hscs_flutter_app/utils/index.dart';

class AppIcons
{
  static Image _tabIcon(String img) => loadLocalImage(img,width: Adapt.px(18),height: Adapt.px(18));
  static Image tabHome = _tabIcon('tab/tab_home_normal');
  static Image tabHomeSelect = _tabIcon('tab/tab_home_select');
  static Image tabLive = _tabIcon('tab/tab_live_normal');
  static Image tabLiveSelect = _tabIcon('tab/tab_live_select');
  static Image tabVip = _tabIcon('tab/tab_vip_normal');
  static Image tabVipSelect = _tabIcon('tab/tab_vip_select');
  static Image tabMine = _tabIcon('tab/tab_mine_normal');
  static Image tabMineSelect = _tabIcon('tab/tab_mine_select');
}