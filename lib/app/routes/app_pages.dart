import 'package:get/get.dart';

import '../modules/add_infaq/bindings/add_infaq_binding.dart';
import '../modules/add_infaq/views/add_infaq_view.dart';
import '../modules/add_marriage/bindings/add_marriage_binding.dart';
import '../modules/add_marriage/views/add_marriage_view.dart';
import '../modules/base/bindings/base_binding.dart';
import '../modules/base/views/base_view.dart';
import '../modules/bible/bindings/bible_binding.dart';
import '../modules/bible/views/bible_view.dart';
import '../modules/community/bindings/community_binding.dart';
import '../modules/community/views/community_view.dart';
import '../modules/giving/bindings/giving_binding.dart';
import '../modules/giving/views/giving_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/infaq/bindings/infaq_binding.dart';
import '../modules/infaq/views/infaq_view.dart';
import '../modules/marriage/bindings/marriage_binding.dart';
import '../modules/marriage/views/marriage_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/scan/bindings/scan_binding.dart';
import '../modules/scan/views/scan_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/signup/bindings/signup_binding.dart';
import '../modules/signup/views/signup_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.BASE,
      page: () => BaseView(),
      binding: BaseBinding(),
    ),
    GetPage(
      name: _Paths.COMMUNITY,
      page: () => const CommunityView(),
      binding: CommunityBinding(),
    ),
    GetPage(
      name: _Paths.SCAN,
      page: () => const ScanView(),
      binding: ScanBinding(),
    ),
    GetPage(
      name: _Paths.GIVING,
      page: () => const GivingView(),
      binding: GivingBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BIBLE,
      page: () => const BibleView(),
      binding: BibleBinding(),
    ),
    GetPage(
      name: _Paths.INFAQ,
      page: () => const InfaqView(),
      binding: InfaqBinding(),
    ),
    GetPage(
      name: _Paths.ADD_INFAQ,
      page: () => const AddInfaqView(),
      binding: AddInfaqBinding(),
    ),
    GetPage(
      name: _Paths.ADD_MARRIAGE,
      page: () => const AddMarriageView(),
      binding: AddMarriageBinding(),
    ),
    GetPage(
      name: _Paths.MARRIAGE,
      page: () => const MarriageView(),
      binding: MarriageBinding(),
    ),
  ];
}
