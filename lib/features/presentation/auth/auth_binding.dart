import 'package:get/get.dart';
import '../../../core/network/api_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find<ApiClient>()));
    Get.lazyPut<AuthController>(() => AuthController(Get.find<AuthRepository>()));
  }
}
