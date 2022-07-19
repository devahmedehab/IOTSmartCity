import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:smart_city/modules/home/cubit/cubit.dart';
import 'package:smart_city/modules/home/cubit/states.dart';
import 'package:smart_city/modules/home/home_screen.dart';
import 'package:smart_city/shared/components/components.dart';

class GatePassword extends StatefulWidget {
  @override
  _GatePassword createState() => _GatePassword();
}

class _GatePassword extends State<GatePassword> {
  var formKey = GlobalKey<FormState>();
  var passController = TextEditingController();

  String currentText = "";
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is HomePostSuccessPassState)
        {

          if(state.passModel.status)
          {
            print(state.passModel.message);
            print(state.passModel.data.password);

            navigateAndFinish(context, HomeScreen());

            showToast(
              text: HomeCubit.get(context).passModel.message,
              state: ToastStates.SUCCESS,


            );
            print(state.passModel.message);



          }
        }
        else
        {

          showToast(
            text: HomeCubit.get(context).passModel.message,
            state: ToastStates.ERROR,

          );
          print(HomeCubit.get(context).passModel.message);
        }

      },
      builder: (context, state) {

        timeDilation = 3.0;
        return Scaffold(
          appBar:defaultAppBar(context: context, title: 'Gate Password'),
          body: GestureDetector(
            onTap: () {},
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height / 4,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset("assets/images/gate.png"),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Gate Password',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                      padding:  EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 50),
                      child: PinCodeTextField(

                        controller: passController,
                        appContext: context,
                        pastedTextStyle: TextStyle(
                          color: Colors.green.shade600,
                          fontWeight: FontWeight.bold,
                        ),
                        length: 4,
                        obscureText: true,
                        obscuringCharacter: '*',
                        obscuringWidget: const Text(
                          "*",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        blinkWhenObscuring: true,
                        animationType: AnimationType.fade,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Your Password';
                          } else
                            return null;
                        },
                        pinTheme: PinTheme(
                          inactiveColor: Colors.grey[200],
                          inactiveFillColor: Colors.white,
                          selectedFillColor: Colors.white,
                          activeColor: Colors.blueGrey,
                          disabledColor: Colors.grey,
                          selectedColor: Colors.blueGrey,
                          errorBorderColor: Colors.redAccent,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 40,
                          activeFillColor: Colors.white,
                        ),
                        cursorColor: Colors.black,
                        animationDuration: const Duration(milliseconds: 300),
                        enableActiveFill: true,


                        keyboardType: TextInputType.number,
                        boxShadows: const [
                          BoxShadow(
                            offset: Offset(0, 1),
                            color: Colors.black,
                            blurRadius: 0,
                          )
                        ],
                        onCompleted: (v) {
                          if (kDebugMode) {
                            print("Completed");
                          }
                        },

                        onChanged: (value) {
                          if (kDebugMode) {
                            print(value);
                          }
                          setState(() {
                            currentText = value;
                          });
                        },
                        beforeTextPaste: (text) {
                          return true;
                        },
                      )),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                      margin:
                      const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
                      child: ButtonTheme(
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            HomeCubit.get(context).postPassData(
                              pass: passController.text
                            );
                          },
                          child:  Center(
                              child: Text(
                                  "Open",
                                  style: TextStyle(color: Colors.white)
                              )
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      )
                  ),


                ],
              ),
            ),
          ),
        );
      },
    );
  }
}