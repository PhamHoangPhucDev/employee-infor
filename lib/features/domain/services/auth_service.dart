import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../entities/user.dart';

class AuthService extends GetxService {
   final _box = GetStorage();
  final Rxn<User> _user = Rxn<User>();


  User? get user => _user.value;
  bool get isLoggedIn => _user.value != null;

  Future<AuthService> init() async {
    // init storage (idempotent)
    await loadUser();
    return this;
  }
  Future<void> loadUser() async {
    await GetStorage.init();
    final raw = _box.read('user');
    if (raw != null && raw is Map) {
      _user.value = User.fromJson(Map<String, dynamic>.from(raw));
    }
  }

  Future<void> saveUser(User user) async {
    _user.value = user;
    await _box.write('user', user.toJson());
  }

  Future<void> clearUser() async {
    _user.value = null;
    await _box.remove('user');
  }
}
