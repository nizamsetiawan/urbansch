import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/daftar_c.dart';
import 'package:urbanscholaria_app/routes/routes.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:urbanscholaria_app/widgets/inputdata_card.dart';

class DaftarView extends StatelessWidget {
  final DaftarC controller = Get.put(DaftarC());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final TextEditingController ktpController = TextEditingController();
  final TextEditingController identityTypeController = TextEditingController();
  final TextEditingController identityNumberController =
      TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController placeOfBirthController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController districtController = TextEditingController();
  final TextEditingController subDistrictController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appwhite,
        title: const Text(
          "Daftar",
          style: TextStyle(color: appneutral600, fontSize: 20),
        ),
        centerTitle: false,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.offAllNamed(RouteNames.onboarding);
          },
          child: const Icon(
            Icons.arrow_back,
            color: appneutral600,
            size: 20,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10,
          ),
          const Center(
            child: Text(
              "Mari Bergabung di US!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Nama Lengkap",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: fullNameController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Nama Lengkap...'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Nama",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: nameController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Nama...'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: emailController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Email'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Kata Sandi",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: Obx(() => TextField(
                        controller: passwordController,
                        autocorrect: false,
                        obscureText: controller.isPasswordHidden.value,
                        style:
                            const TextStyle(fontSize: 12, color: appneutral900),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding:
                              const EdgeInsets.fromLTRB(16, 7, 16, 10),
                          hintText: "Masukkan Kata Sandi",
                          suffixIcon: IconButton(
                            icon: Icon(controller.isPasswordHidden.value
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: appneutral400,
                            onPressed: () {
                              controller.isPasswordHidden.value =
                                  !controller.isPasswordHidden.value;
                            },
                          ),
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                        ),
                      )),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Jenis Identitas",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: appneutral400),
                  ),
                  child: Obx(
                    () => DropdownButton<String>(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      value: controller.jenis_identitas.value,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      isExpanded: true,
                      style:
                          const TextStyle(fontSize: 12, color: appneutral900),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.setJenis_identitas(newValue);
                        }
                      },
                      items: <String>['KTP']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "NIK",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: identityNumberController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'NIK harus terdiri dari 16 digit'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Jenis Kelamin",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),

                Container(
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    border: Border.all(color: appneutral400),
                  ),
                  child: Obx(
                    () => DropdownButton<String>(
                      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                      value: controller.jenis_kelamin.value,
                      icon: const Icon(Icons.arrow_drop_down_sharp),
                      isExpanded: true,
                      style:
                          const TextStyle(fontSize: 12, color: appneutral900),
                      underline: Container(
                        height: 0,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.setjenis_kelamin(newValue);
                        }
                      },
                      items: <String>['Laki-Laki', 'Perempuan']
                          .map<DropdownMenuItem<String>>(
                            (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Tempat Lahir",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: placeOfBirthController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Tempat Lahir'),
                  ),
                ),
                // Inside DaftarView class
// ...

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Tanggal Lahir",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                GestureDetector(
                  onTap: () {
                    controller.selectDate(context, dateOfBirthController);
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AbsorbPointer(
                            child: TextField(
                              controller: dateOfBirthController,
                              autocorrect: false,
                              style:
                                  TextStyle(fontSize: 12, color: appneutral900),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 0, 16, 10),
                                hintText: 'Masukkan Tanggal Lahir',
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16, right: 16),
                          child: Icon(
                            Icons.calendar_today,
                            color: appneutral500,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
// ...

                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Provinsi",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: provinceController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Provinsi'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Kota/Kabupaten",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: cityController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Kota/Kabupaten'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Kecamatan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: districtController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Kecamatan'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Desa/Kelurahan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: subDistrictController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Desa/Kelurahan'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Alamat",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: addressController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Alamat'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Nomer HP",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: phoneNumberController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Nomer HP'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Pekerjaan",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      border: Border.all(color: appneutral400)),
                  child: TextField(
                    controller: jobController,
                    autocorrect: false,
                    style: TextStyle(fontSize: 12, color: appneutral900),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 10),
                        hintText: 'Masukkan Jabatan'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),

                PermissionWidget(
                  viewModel: PermissionViewModel(
                    hintText: 'Pilih Foto',
                    subTitle: 'Pilih foto untuk profil',
                  ),
                  onFilePicked: (title, filePath) {
                    photoController.text = filePath;
                  },
                ),
                //foto ktp
                PermissionWidget(
                  viewModel: PermissionViewModel(
                    hintText: 'Pilih Foto KTP',
                    subTitle: 'Pilih foto KTP untuk verifikasi identitas',
                  ),
                  onFilePicked: (title, filePath) {
                    ktpController.text = filePath;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: () {
                    final email = emailController.text;
                    final username = nameController.text;
                    final password = passwordController.text;
                    final nama_lengkap = fullNameController.text;
                    final foto = photoController.text;
                    final ktp = ktpController.text;
                    final jenis_identitas = controller.jenis_identitas.value;
                    final nomor_identitas = identityNumberController.text;
                    final jenis_kelamin = controller.jenis_kelamin.value;
                    final tempat_lahir = placeOfBirthController.text;
                    final tanggal_lahir = dateOfBirthController.text;
                    final provinsi = provinceController.text;
                    final kabupaten_kota = cityController.text;
                    final kecamatan = districtController.text;
                    final kelurahan = subDistrictController.text;
                    final alamat = addressController.text;
                    final no_telp = phoneNumberController.text;
                    final pekerjaan = jobController.text;

                    // Check if any field is empty
                    if (email.isNotEmpty &&
                        username.isNotEmpty &&
                        password.isNotEmpty &&
                        nama_lengkap.isNotEmpty &&
                        foto.isNotEmpty &&
                        ktp.isNotEmpty &&
                        jenis_identitas.isNotEmpty &&
                        nomor_identitas.isNotEmpty &&
                        jenis_kelamin.isNotEmpty &&
                        tempat_lahir.isNotEmpty &&
                        tanggal_lahir.isNotEmpty &&
                        provinsi.isNotEmpty &&
                        kabupaten_kota.isNotEmpty &&
                        kecamatan.isNotEmpty &&
                        kelurahan.isNotEmpty &&
                        alamat.isNotEmpty &&
                        no_telp.isNotEmpty &&
                        pekerjaan.isNotEmpty) {
                      controller.daftar(
                        email,
                        username,
                        password,
                        nama_lengkap,
                        foto,
                        ktp,
                        jenis_identitas,
                        nomor_identitas,
                        jenis_kelamin,
                        tempat_lahir,
                        tanggal_lahir,
                        provinsi,
                        kabupaten_kota,
                        kecamatan,
                        kelurahan,
                        alamat,
                        no_telp,
                        pekerjaan,
                      );
                    } else {
                      Get.snackbar(
                        'Peringatan',
                        'Lengkapi data terlebih dahulu',
                        backgroundColor: appdanger500,
                        colorText: appwhite,
                      );
                    }
                  },
                  child: ButtonWidgets(label: 'Daftar Sekarang'),
                ),

                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sudah ada akun?",
                      style: TextStyle(
                        color: appneutral600,
                        fontSize: 14,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.offAllNamed(RouteNames.login);
                      },
                      child: const Text(
                        "\tMasuk",
                        style: TextStyle(
                            color: appbrand500,
                            fontWeight: FontWeight.w500,
                            fontSize: 14),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
