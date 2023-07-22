import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_app/models/register_user.dart';

enum PrefKeys { loggedIn, name, phone, email, token, isActiveCard,isDark,showHome}

class SharedPrefController {
  static final SharedPrefController _instance = SharedPrefController._();

  SharedPrefController._();

  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  //required String token
  Future<void> save({required User user, required var token}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.toString(), true);
    await _sharedPreferences.setString(PrefKeys.name.toString(), user.name);
    await _sharedPreferences.setString(PrefKeys.phone.toString(), user.phone);
    await _sharedPreferences.setString(PrefKeys.email.toString(), user.email);

    await _sharedPreferences.setString(
        PrefKeys.token.toString(), 'Bearer ' + token);
    await _sharedPreferences.setString(
        PrefKeys.isActiveCard.toString(), user.card_active);
  }

  // changeMode({bool? fromShared}) async{
  //   if (fromShared == null) {
  //     //for the first time
  //     //and when click on change mode button
  //     bool dark=true;
  //     await _sharedPreferences.setBool('mode',dark);
  //   } else {
  //     //when you make run again
  //     _isDark = fromShared;
  //   }
  // }

  bool get loggedIn =>
      _sharedPreferences.getBool(PrefKeys.loggedIn.toString()) ?? false;

  bool get showHome =>
      _sharedPreferences.getBool(PrefKeys.showHome.toString()) ?? false;

  String get token =>
      _sharedPreferences.getString(PrefKeys.token.toString()) ?? '';

  String get name =>
      _sharedPreferences.getString(PrefKeys.name.toString()) ?? '';

  String get mobile =>
      _sharedPreferences.getString(PrefKeys.phone.toString()) ?? '';

  String get gender =>
      _sharedPreferences.getString(PrefKeys.email.toString()) ?? '';

  String? get isActiveCard =>
      _sharedPreferences.getString(PrefKeys.isActiveCard.toString());

  setShowHome(bool value) async {
    await _sharedPreferences.setBool(PrefKeys.showHome.toString(), value);
  }

  setIsActiveCard(String value) async {
    await _sharedPreferences.setString(PrefKeys.isActiveCard.toString(), value);
  }
  bool get isDark =>
      _sharedPreferences.getBool(PrefKeys.isDark.toString()) ?? false;
  setIsDark(bool value) async {
    await _sharedPreferences.setBool(PrefKeys.isDark.toString(), value);
  }

  Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }
}
