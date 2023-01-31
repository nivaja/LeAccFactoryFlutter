import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:leacc_factory/app/modules/common/views/button.dart';
import 'package:leacc_factory/app/modules/http/dio.dart';
import 'package:leacc_factory/app/modules/login/views/login_view.dart';

import '../controllers/preference_controller.dart';

class PreferenceView extends GetView<PreferenceController> {
  const PreferenceView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PreferenceView'),
        centerTitle: true,
      ),
      body: Center(
        child: FrappeButtonField(
          buttonText: 'Logout',
           onPressed: () async{

            await DioClient().get('/method/logout');
            GetStorage().remove('Config');
            Get.offAll(LoginView());

           }, 
          buttonTextColor: TextStyle(color: Colors.redAccent),
        ),
      ),
    );
  }
}
