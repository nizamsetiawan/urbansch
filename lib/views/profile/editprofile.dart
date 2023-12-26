import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:urbanscholaria_app/constant/colors.dart';
import 'package:urbanscholaria_app/controllers/profile_c.dart';
import 'package:urbanscholaria_app/widgets/button.dart';
import 'package:urbanscholaria_app/widgets/editprofile_teksfield.dart';

class EditProfileView extends StatelessWidget {
  final EditProfileController controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbrand500,
        title: const Text("Data Profile"),
        centerTitle: true,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.arrow_back_ios_new),
        ),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/icons/ditolak.png",
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: 200,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Ganti Foto Profile",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: appbrand500,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 16),
                                child: Divider(
                                  color: appneutral200,
                                  thickness: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Informasi Akun",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: appbrand800,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextFieldContainer(
                              title: "Alamat Email",
                              controller: controller.emailController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Nomor Hp",
                              controller: controller.noTelpController,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Pekerjaan",
                              controller: controller.pekerjaanController,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Divider(
                                color: appneutral200,
                                thickness: 3,
                              ),
                            ),
                            Text(
                              "Identitas Akun",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: appbrand800,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextFieldContainer(
                              title: "Nama Lengkap",
                              controller: controller.namaLengkapController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Nomor Identitas",
                              controller: controller.nomorIdentitasController,
                              enabled: false,
                            ),
                            CustomTextFieldContainer(
                              title: "Tempat Lahir",
                              controller: controller.tempatLahirController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Masukkan Tanggal Lahir",
                              controller: controller.tanggalLahirController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Masukkan Jenis Kelamin",
                              controller: controller.jenisKelaminController,
                              enabled: false,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 16, bottom: 16),
                              child: Divider(
                                color: appneutral200,
                                thickness: 3,
                              ),
                            ),
                            Text(
                              "Domisili",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: appbrand800,
                              ),
                            ),
                            SizedBox(height: 10),
                            CustomTextFieldContainer(
                              title: "Provinsi",
                              controller: controller.provinsiController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Masukkan Kota/Kabupaten",
                              controller: controller.kabupatenKotaController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Masukkan Kecamtan",
                              controller: controller.kecamatanController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Masukkan Desa/Kelurahan",
                              controller: controller.kelurahanController,
                              enabled: false,
                            ),
                            SizedBox(height: 5),
                            CustomTextFieldContainer(
                              title: "Masukkan Alamat",
                              controller: controller.alamatController,
                              enabled: false,
                            ),
                            CheckboxListTile(
                              activeColor: appbrand500,
                              title: Text(
                                'Saya menyatakan bahwa seluruh data benar.',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: appneutral500,
                                ),
                              ),
                              value: controller.isChecked.value,
                              onChanged: controller.isLoading.value
                                  ? null
                                  : (newValue) {
                                      controller.isChecked(newValue ?? false);
                                    },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            GestureDetector(
                              onTap: controller.isLoading.value
                                  ? null
                                  : () {
                                      if (controller.isChecked.value) {
                                        controller.saveData();
                                      } else {
                                        Get.snackbar(
                                          'Peringatan',
                                          'Harap centang kotak persetujuan',
                                          backgroundColor: appdanger500,
                                          colorText: Colors.white,
                                        );
                                      }
                                    },
                              child: ButtonWidgets(
                                label: "Simpan",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
