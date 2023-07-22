import 'package:flutter/material.dart';
import 'package:university_app/prefs/shared_prefs_controller.dart';

class SettingsModel extends ChangeNotifier{
  bool _isDark=false;
  bool get isDark=>_isDark;

  changeMode({bool? fromShared}){
    if(fromShared ==null){

      _isDark = !_isDark;
      SharedPrefController().setIsDark(_isDark).then((value) {
        notifyListeners();
      } );
      notifyListeners();
    }else{
      //when you make run again
      _isDark = fromShared;
      notifyListeners();

    }

  }
}