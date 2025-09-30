import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../features/domain/services/auth_service.dart';
import '../network/api_client.dart';

/// Binding GetX cho các feature
class AppBindings extends Bindings {
  @override
  void dependencies() {
    // Inject global services, dùng lại ở nhiều feature

    Get.putAsync<GetStorage>(() async {
      await GetStorage.init();
      return GetStorage();
    });

    // Ví dụ: Những SharedPrefs, NotificationService,ApiService, LocalStorage, UserRepository...dùng cho toàn app

    // ApiClient singleton (permanent)
    // Get.put<ApiClient>(ApiClient(baseUrl: 'https://api.yourdomain.com'), permanent: true);
    Get.put<ApiClient>(ApiClient(), permanent: true); 
    
    // AuthService: init GetStorage + load user (async), keep permanent
    Get.putAsync<AuthService>(
      () async => await AuthService().init(),
      permanent: true,
    );
  }
}
