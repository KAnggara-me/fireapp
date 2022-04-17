import 'package:http/http.dart';

import '../../constant/size.dart';
import 'package:flutter/material.dart';

import '../../controllers/c_sensor.dart';
import '../../helpers/keyboard.dart';
import '../../widgets/w_button.dart';

class UpdateSensor extends StatefulWidget {
  const UpdateSensor({
    Key? key,
    required this.id,
    required this.ruangan,
  }) : super(key: key);
  final int id;
  final String ruangan;

  @override
  State<UpdateSensor> createState() => _UpdateSensorState();
}

class _UpdateSensorState extends UpdateSensorController {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    String ruangan = widget.ruangan;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          'Edit $ruangan',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(25)!,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.05,
                  ),
                  Text(
                    "Update or Delete Sensor",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: getProportionateScreenWidth(18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.screenHeight * 0.03,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: getProportionateScreenHeight(30),
                        ),
                        ruanganField(),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        loading
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  SizedBox(
                                    height: getProportionateScreenHeight(30),
                                  ),
                                ],
                              )
                            : Text(
                                msg,
                                style: const TextStyle(
                                    fontSize: 20.0, color: Colors.red),
                              ),
                        DefaultButton(
                          text: "Update",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              KeyboardUtil.hideKeyboard(context);
                              cek();
                            }
                          },
                        ),
                        SizedBox(
                          height: getProportionateScreenHeight(15),
                        ),
                        DefaultButton(
                          text: "Delete",
                          bgcolor: const Color.fromARGB(255, 184, 56, 47),
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();
                              KeyboardUtil.hideKeyboard(context);
                              del();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
