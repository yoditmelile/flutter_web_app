import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_web_app/Service/Auth_Service.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({super.key});

  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "send";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationIdFinal = "";
  String smsCode = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Sign Up",
            style: TextStyle(color: Colors.white, fontSize: 24)),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(children: [
            SizedBox(height: 110),
            textField(),
            SizedBox(height: 30),
            Container(
              width: MediaQuery.of(context).size.width - 30,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                  Text(
                    "Enter 6 digit OTP",
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: Colors.grey,
                      margin: EdgeInsets.symmetric(horizontal: 12),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            otpField(),
            SizedBox(height: 40),
            RichText(
                text: TextSpan(children: [
              TextSpan(
                text: "Send OTP again in ",
                style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
              ),
              TextSpan(
                text: "00:$start ",
                style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
              ),
              TextSpan(
                text: "Sec",
                style: TextStyle(fontSize: 16, color: Colors.yellowAccent),
              ),
            ])),
            SizedBox(height: 120),
            InkWell(
              onTap: () {
                authClass.signInwithPhoneNumber(
                    verificationIdFinal, smsCode, context);
              },
              child: Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: BoxDecoration(
                      // color: Colors.white,
                      gradient: const LinearGradient(colors: [
                        Color(0xfffd746c),
                        Color(0xffff9068),
                        Color(0xfffd746c),
                      ]),
                      borderRadius: BorderRadius.circular(15)),
                  child: Center(
                    child: Text(
                      "Let's Go",
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )),
            )
          ]),
        ),
      ),
    );
  }

  void startTimer() {
    const OnSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(OnSec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 34,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Color(0xff1d1d1d),
        borderColor: Colors.white,
      ),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
      width: MediaQuery.of(context).size.width - 40,
      height: 60,
      decoration: BoxDecoration(
          color: Color(0xff1d1d1d), borderRadius: BorderRadius.circular(15)),
      child: TextFormField(
        controller: phoneController,
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Enter your phone number",
          hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
          contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
            child: Text(
              "(+251)",
              style: TextStyle(color: Colors.white54, fontSize: 17),
            ),
          ),
          suffixIcon: InkWell(
            onTap: wait
                ? null
                : () async {
                    startTimer();
                    setState(() {
                      start = 30;
                      wait = true;
                      buttonName = "Resend";
                    });
                    await authClass.verifyPhoneNumber(
                        "+251 ${phoneController.text}", context, setData);
                  },
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Text(
                buttonName,
                style: TextStyle(
                    color: wait ? Colors.grey : Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void setData(verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });

    startTimer();
  }
}
