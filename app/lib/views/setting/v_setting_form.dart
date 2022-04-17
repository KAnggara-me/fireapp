import '../../constant/size.dart';
import '../../helpers/keyboard.dart';
import '../../widgets/w_button.dart';
import 'package:flutter/material.dart';
import '../../controllers/c_setting.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);
  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends SettingController {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          tempField(),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          mq2Field(),
          SizedBox(
            height: getProportionateScreenHeight(15),
          ),
          loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Text(
                  msg,
                  style: const TextStyle(fontSize: 20.0, color: Colors.red),
                ),
          DefaultButton(
            text: "Submit",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                cek();
              }
            },
          ),
        ],
      ),
    );
  }
}
