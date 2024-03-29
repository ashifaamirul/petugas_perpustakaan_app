import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart 'as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:petugas_perpustakaan_app/app/data/constant/endpoint.dart';
import 'package:petugas_perpustakaan_app/app/data/provider/api_provider.dart';
import 'package:petugas_perpustakaan_app/app/data/provider/storage_provider.dart';
import 'package:petugas_perpustakaan_app/app/routes/app_pages.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwodController = TextEditingController();

  //TODO: Implement LoginController

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;

  final loadingLogin = false.obs;

  login() async {
    loadingLogin(true);
    try {
      //untuk tidak memunculkan keyboard
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "username": usernameController.text.toString(),
                  "password": passwodController.text.toString()
                }));
        if (response.statusCode == 200) {
          await StorageProvider.write(StorageKey.status, "logged");
          Get.offAllNamed(Routes.HOME);
        } else {
          Get.snackbar("Sorry", "Login Gagal", backgroundColor: Colors.orange);
        }
      }
      loadingLogin(false);
    } on dio.DioException catch (e) {
      loadingLogin(false);
      Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
    } catch (e) {
      loadingLogin(false);
      Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
      throw Exception('Error: $e');
    }
  }
}
