import 'package:get/get.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/views/beranda.dart';
import 'package:urbanscholaria_app/views/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/chat.dart';
import 'package:urbanscholaria_app/views/daftar.dart';
import 'package:urbanscholaria_app/views/detailjenisperizinan.dart';
import 'package:urbanscholaria_app/views/kategoriperizinan/SD/perizinansd.dart';
import 'package:urbanscholaria_app/views/kategoriperizinan/SMA/perizinansma.dart';
import 'package:urbanscholaria_app/views/kategoriperizinan/SMP/perizinansmp.dart';
import 'package:urbanscholaria_app/views/kategoriperizinan/TK/perizinantk.dart';
import 'package:urbanscholaria_app/views/login.dart';
import 'package:urbanscholaria_app/views/newpass.dart';
import 'package:urbanscholaria_app/views/onboarding.dart';
import 'package:urbanscholaria_app/views/profile.dart';
import 'package:urbanscholaria_app/views/profile/about_view.dart';
import 'package:urbanscholaria_app/views/profile/editprofile.dart';
import 'package:urbanscholaria_app/views/profile/faq_view.dart';
import 'package:urbanscholaria_app/views/profile/syaratketen_view.dart';
import 'package:urbanscholaria_app/views/resetpass.dart';
import 'package:urbanscholaria_app/views/riwayat.dart';
import 'package:urbanscholaria_app/views/scan.dart';
import 'package:urbanscholaria_app/views/splashscreen.dart';

class AppPage {
  static final pages = [
    //login daftar
    GetPage(
      name: RouteNames.splashscreen,
      page: () => SplashscreenView(),
    ),
    GetPage(
      name: RouteNames.onboarding,
      page: () => OnboardingView(),
    ),
    GetPage(
      name: RouteNames.daftar,
      page: () => DaftarView(),
    ),
    GetPage(
      name: RouteNames.login,
      page: () => LoginView(),
    ),
    GetPage(
      name: RouteNames.newpass,
      page: () => NewpassView(),
    ),
    GetPage(
      name: RouteNames.resetpass,
      page: () => ResetPassView(),
    ),
    //bottom
    GetPage(
      name: RouteNames.bottomnavigation,
      page: () => BottomnavigationView(),
    ),
    GetPage(
      name: RouteNames.beranda,
      page: () => BerandaView(),
    ),
    GetPage(
      name: RouteNames.chat,
      page: () => ChatView(),
    ),
    GetPage(
      name: RouteNames.scan,
      page: () => ScanView(),
    ),
    GetPage(
      name: RouteNames.profile,
      page: () => ProfileView(),
    ),
    GetPage(
      name: RouteNames.riwayat,
      page: () => RiwayatView(),
    ),
    //profile
    GetPage(
      name: RouteNames.editprofile,
      page: () => EditProfileView(),
    ),
    GetPage(
      name: RouteNames.faq,
      page: () => FAQView(),
    ),
    GetPage(
      name: RouteNames.syaratdanketentuan,
      page: () => SyaratDanKetentuanView(),
    ),
    GetPage(
      name: RouteNames.about,
      page: () => AboutView(),
    ),
    GetPage(
      name: RouteNames.about,
      page: () => AboutView(),
    ),
    //kategoriperizinan
    GetPage(
      name: RouteNames.perizinantk,
      page: () => TKPerizinanView(),
    ),
    GetPage(
      name: RouteNames.perizinansd,
      page: () => SDPerizinanView(),
    ),
    GetPage(
      name: RouteNames.perizinansmp,
      page: () => SMPPerizinanView(),
    ),
    GetPage(
      name: RouteNames.perizinansma,
      page: () => SMAPerizinanView(),
    ),
    //detailjenisperizinan
    GetPage(
      name: RouteNames.detailjenisperizinan,
      page: () => DetailJenisPerizinanView(),
    ),
  ];
}
