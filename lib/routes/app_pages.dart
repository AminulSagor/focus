import 'package:focus/modules/home/home_controller.dart';
import 'package:focus/modules/home/home_view.dart';
import 'package:get/get.dart';
import '../modules/login/login_view.dart';
import '../modules/login/login_controller.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.login,
      page: () => LoginView(),
      binding: BindingsBuilder(() => Get.put(LoginController())),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => HomeView(),
      binding: BindingsBuilder(() => Get.put(HomeController())),
    ),
  ];
}
