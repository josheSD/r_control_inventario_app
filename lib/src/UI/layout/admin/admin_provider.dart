import 'package:controlinventario/src/core/shared-preferences/user.preference.dart';
import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class AdminProvider with ChangeNotifier {

  signOut(){
    
    final userPreference = new UserPreference();
    userPreference.clearSharedPreferences();

  }

}
