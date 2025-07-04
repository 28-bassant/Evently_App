import 'package:flutter/cupertino.dart';

class AppLanguageProvider extends ChangeNotifier{
  String appLanguage = 'en';
  void changeLanguage(String newLanguage){
    if(appLanguage == newLanguage){
      return;
    }
    appLanguage = newLanguage;
    notifyListeners();
  }

  bool isArabic() {
    return appLanguage == 'ar';
  }
}