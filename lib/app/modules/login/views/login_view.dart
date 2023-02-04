import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:leacc_factory/app/modules/home/views/home_view.dart';

import '../../../data/login_provider.dart';
import 'package:dio/dio.dart' as dio;
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();


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
          child: FormBuilder(
            key: _formKey,
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

              FormBuilderTextField(
                name: 'server',
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.url(
                    protocols: ['http','https'],

                  )
                ]
                ),
                decoration: FrappeInputDecoration(label: 'Server', fieldIcons: const Icon(Icons.sensors)),
              ),
                SizedBox(height: 15,),

                FormBuilderTextField(
                  name: 'usr',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email()
                  ]),
                  decoration: FrappeInputDecoration(label: 'Username', fieldIcons: const Icon(Icons.email_outlined)),

                ),
                SizedBox(height: 15,),

                FormBuilderTextField(
                  name: 'pwd',
                  obscureText: true,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),

                  ]),
                  decoration: FrappeInputDecoration(label: 'Password', fieldIcons: const Icon(Icons.password_outlined)),

                )
                ,
                SizedBox(height: 15,),

                Expanded(
                  child: ElevatedButton(
                    onPressed: () async{
                      if (_formKey.currentState?.saveAndValidate() ?? false) {
                        dio.Response? response = await LoginProvider().post(server: _formKey.currentState?.value['server'],
                            usr:_formKey.currentState?.value['usr'],
                          pwd: _formKey.currentState?.value['pwd']

                        );
                        if(response != null){
                          Get.offAll(HomeView());
                        }

                      } else {
                        print(_formKey.currentState?.value);
                        debugPrint('validation failed');
                      }
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration FrappeInputDecoration(
      {required String label, required Icon fieldIcons}) {
    return InputDecoration(
        fillColor: Colors.grey[100],
        filled: true,
        border: OutlineInputBorder(),
        icon: fieldIcons,
        labelText: label,
        labelStyle: TextStyle(
          color: Colors.blue[600],
        )
    );
  }
}

