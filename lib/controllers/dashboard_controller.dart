import 'package:coworker/pages/fragments/browser_fragment.dart';
import 'package:coworker/pages/fragments/order_fragment.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../pages/fragments/setting_fragment.dart';

class DashboardController extends GetxController {
  void clear() {
    Get.delete<DashboardController>(force: true);
  }

  final _index = 0.obs;
  int get index => _index.value;
  set index(int n) => _index.value = n;

  Widget get currentFragment => menu[index]['fragment'];

  List<Map> menu = [
    {
      'icon_off': 'assets/ic_browse_grey.png',
      'icon_on': 'assets/ic_browse_purple.png',
      'label': 'Browse',
      'fragment': const BrowserFragment(),
    },
    {
      'icon_off': 'assets/ic_orders_grey.png',
      'icon_on': 'assets/ic_orders_purple.png',
      'label': 'Orders',
      'fragment': const OrderFragment(),
    },
    {
      'icon_off': 'assets/ic_wallet_grey.png',
      'icon_on': 'assets/ic_wallet_purple.png',
      'label': 'Wallet',
      'fragment': DView.empty('Wallet'),
    },
    {
      'icon_off': 'assets/ic_settings_grey.png',
      'icon_on': 'assets/ic_settings_purple.png',
      'label': 'Settings',
      'fragment': const SettingFragment(),
    },
  ];
}
