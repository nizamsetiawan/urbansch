import 'package:get/get.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/views/admindinas/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/adminutama/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/operator/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/operator/dashboard.dart';
import 'package:urbanscholaria_app/views/pemohon/ajukanperizinan.dart';
import 'package:urbanscholaria_app/views/pemohon/ajukanperizinanfile.dart';
import 'package:urbanscholaria_app/views/pemohon/beranda.dart';
import 'package:urbanscholaria_app/views/pemohon/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/chat.dart';
import 'package:urbanscholaria_app/views/daftar.dart';
import 'package:urbanscholaria_app/views/pemohon/detailjenisperizinan.dart';
import 'package:urbanscholaria_app/views/pemohon/kategoriperizinan/SD/perizinansd.dart';
import 'package:urbanscholaria_app/views/pemohon/kategoriperizinan/SMA/perizinansma.dart';
import 'package:urbanscholaria_app/views/pemohon/kategoriperizinan/SMP/perizinansmp.dart';
import 'package:urbanscholaria_app/views/pemohon/kategoriperizinan/TK/perizinantk.dart';
import 'package:urbanscholaria_app/views/login.dart';
import 'package:urbanscholaria_app/views/newpass.dart';
import 'package:urbanscholaria_app/views/notifikasi.dart';
import 'package:urbanscholaria_app/views/onboarding.dart';
import 'package:urbanscholaria_app/views/operator/detailscreenverifikasi.dart';
import 'package:urbanscholaria_app/views/operator/perizinan.view.dart';
import 'package:urbanscholaria_app/views/operator/verifikasi.dart';
import 'package:urbanscholaria_app/views/profile.dart';
import 'package:urbanscholaria_app/views/profile/about_view.dart';
import 'package:urbanscholaria_app/views/profile/editprofile.dart';
import 'package:urbanscholaria_app/views/profile/faq_view.dart';
import 'package:urbanscholaria_app/views/profile/syaratketen_view.dart';
import 'package:urbanscholaria_app/views/resetpass.dart';
import 'package:urbanscholaria_app/views/pemohon/riwayat.dart';
import 'package:urbanscholaria_app/views/scan.dart';
import 'package:urbanscholaria_app/views/splashscreen.dart';
import 'package:urbanscholaria_app/views/surveyor/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/verifikasiotp.dart';
import 'package:urbanscholaria_app/views/verifikator/bottomnavbar.dart';
import 'package:urbanscholaria_app/views/verifikator/detailscreenverifikasi.dart';
import 'package:urbanscholaria_app/views/verifikator/penugasansurvey.dart';
import 'package:urbanscholaria_app/views/verifikator/verifikasi.dart';

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
    GetPage(
      name: RouteNames.otp,
      page: () => OtpView(),
    ),
    GetPage(
      name: RouteNames.bottomnavigationoperator,
      page: () => BottomnavigationcontrollerView(),
    ),
    GetPage(
      name: RouteNames.operatordashboard,
      page: () => OperatorDashboardView(),
    ),
    GetPage(
      name: RouteNames.operatorperizinan,
      page: () => OperatorPerizinanView(),
    ),
    GetPage(
      name: RouteNames.operatorverifikasi,
      page: () => OperatorVerifikasiView(),
    ),
    GetPage(
        name: RouteNames.detailscreenverifikasi,
        page: () => DetailScreenVerifikasiView(
              requestData: {},
              namaLengkap: '',
            )),
    GetPage(
      name: RouteNames.bottomnavigationverifikator,
      page: () => VerifikatorBottomView(),
    ),
    GetPage(
      name: RouteNames.bottomnavigationsurveyor,
      page: () => SurveyorBottomView(),
    ),
    GetPage(
      name: RouteNames.bottomnavigationadmindinas,
      page: () => AdminDInasBottomView(),
    ),
    GetPage(
      name: RouteNames.bottomnavigationadminutama,
      page: () => AdminUtamaBottomView(),
    ),
    GetPage(
      name: RouteNames.verifikatorverifikasi,
      page: () => VerifikatorVerifikasiView(),
    ),
    GetPage(
      name: RouteNames.detailverifiaktorverifikasi,
      page: () => DetailVerifikasiVerifikatorView(
        requestData: {},
        namaLengkap: '',
      ),
    ),
    GetPage(
      name: RouteNames.penugasansurvey,
      page: () => PenugasanSurveyView(
        requestData: {},
      ),
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
    //ajukanjenisperizinanform
    GetPage(
      name: RouteNames.ajukanjenisperizinanform,
      page: () => AjukanPerizinanView(),
    ),
    GetPage(
      name: RouteNames.ajukanperizinanfile,
      page: () => AjukanPerizinanFileView(),
    ),
    //notifikasi
    GetPage(
      name: RouteNames.notifikasi,
      page: () => NotifikasiView(),
    ),
  ];
}
