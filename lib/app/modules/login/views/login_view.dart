import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:leacc_factory/app/modules/home/views/home_view.dart';

import '../../../data/login_provider.dart';
import '../../common/views/action_button.dart';
import '../../common/views/input_field_widget.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final  serverController = TextEditingController();
  final  emailController = TextEditingController();
  final  passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LoginView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(45.0),
        child: Expanded(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text('Welcome',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.blue[600],
                      fontSize: 25,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              FrappeTextField(controller:serverController,'Server Address', Icon(Icons.adf_scanner)),
              Padding(padding: EdgeInsets.all(12)),
              FrappeTextField(controller: emailController,'Username', Icon(Icons.person)),
              Padding(padding: EdgeInsets.all(12)),
              FrappeTextField(controller: passwordController,'Password', Icon(Icons.lock),obscureText: true,),
              SizedBox(
                height: 30,
              ),
              FrappeActionButton(buttonText: 'Login',onPressed: () {


                LoginProvider().post(server: serverController.text, usr: emailController.text, pwd: passwordController.text);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

