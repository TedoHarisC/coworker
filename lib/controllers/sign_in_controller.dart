import 'package:coworker/config/app_info.dart';
import 'package:coworker/config/enums.dart';
import 'package:coworker/config/session.dart';
import 'package:coworker/datasources/user_datasource.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  clear() {
    Get.delete<SignInController>(force: true);
  }

  final edtEmail = TextEditingController();
  final edtPassword = TextEditingController();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool n) => _loading.value = n;

  execute(BuildContext context) {
    // Pengecekan validasi email
    if (edtEmail.text == '') {
      AppInfo.failed(context, "Email wajib diisi");
      return;
    }
    if (!GetUtils.isEmail(edtEmail.text)) {
      AppInfo.failed(context, "Email tidak valid");
      return;
    }
    // Pengecekan Validasi Password
    if (edtPassword.text == '') {
      AppInfo.failed(context, "Password wajib diisi");
      return;
    }
    if (edtPassword.text.length < 8) {
      AppInfo.failed(context, "Email minimal 8 karakter");
      return;
    }

    loading = true;

    //Eksekusi Sign Up API (AppWrite nya)
    UserDatasource.signIn(
      edtEmail.text,
      edtPassword.text,
    ).then((value) {
      loading = false;
      value.fold((message) {
        AppInfo.failed(context, message);
      }, (data) {
        // Save ke Session App
        AppSession.setUser(data);
        // Memunculkan toast untuk menunjukkan bahwa sukses untuk login
        AppInfo.toastSucces('Sign In Berhasil');
        // Navigator ke Dashboard setelah sign in
        Navigator.pushReplacementNamed(context, AppRoute.dashboard.name);
      });
    });
  }
}
