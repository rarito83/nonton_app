import 'package:flutter/foundation.dart';
import 'package:nonton_app/common/drawer_item_enum.dart';

class HomeNotifier extends ChangeNotifier {
  DrawerItem _selectedDrawerItem = DrawerItem.Movie;
  DrawerItem get selectedDrawerItem => _selectedDrawerItem;

  void setSelectedDrawerItem(DrawerItem newItem) {
    this._selectedDrawerItem = newItem;
    notifyListeners();
  }
}
