
import 'package:flutter/material.dart';

import '../../models/producto_model.dart';

class ShoppingCartProvider extends ChangeNotifier {

  List<ProductoModel> _listProductsPurchased = [];

  List<ProductoModel> get listProductsPurchased {
    return _listProductsPurchased;
  }

  set selectedMenuOption(List<ProductoModel> list){
    _listProductsPurchased = list;
    notifyListeners();
  }
}