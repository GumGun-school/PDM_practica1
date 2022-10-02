import 'package:flutter/cupertino.dart';

class FavButton with ChangeNotifier {
  bool faved = true;
  
  void startFromFav(){
    faved = true;
    notifyListeners();
  }

  void startFromListener(){
    faved = false;
    notifyListeners();
  }
  
  void changeButton() {
    faved = !faved;
    notifyListeners();
  }
}
