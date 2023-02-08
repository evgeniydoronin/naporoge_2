import 'package:flutter/material.dart';
import 'package:pin_code_text_field/pin_code_text_field.dart';

import '../../../../components/constants.dart';
import 'welcome_screen.dart';
// import 'package:naporoge/domain/auth/user_auth.dart';
// import 'package:pin_code_text_field/pin_code_text_field.dart';

class LoginPhoneConfirmScreen extends StatefulWidget {
  final String phone;

  const LoginPhoneConfirmScreen({Key? key, required this.phone})
      : super(key: key);

  @override
  State<LoginPhoneConfirmScreen> createState() =>
      _LoginPhoneConfirmScreenState();
}

class _LoginPhoneConfirmScreenState extends State<LoginPhoneConfirmScreen> {
  // AuthService authService = AuthService();
  final TextEditingController _otpController = TextEditingController();
  String smsCode = '';
  String verificationIdFinal = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.phone);
    // authService.verifyPhoneNumber(
    //   '+7${widget.phone}',
    //   context,
    //   setData,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text('Вход'),
      ),
      body: LayoutBuilder(
        builder: (context, constraint) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraint.maxHeight),
              child: IntrinsicHeight(
                child: Container(
                  decoration: const BoxDecoration(color: Colors.white),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Column(
                        children: const [
                          Text(
                            'Подтверждение номера',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Мы отправили вам 4-значный код на номер',
                            style: TextStyle(color: ColorApp.secondaryText),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        '+7${widget.phone}',
                        style: const TextStyle(fontSize: 24),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Expanded(
                        child: PinCodeTextField(
                          keyboardType: TextInputType.number,
                          autofocus: true,
                          controller: _otpController,
                          maxLength: 4,
                          // hasUnderline: true,
                          hideCharacter: false,
                          // pinBoxColor: ColorApp.primary,
                          // highlightPinBoxColor: Colors.redAccent,
                          // highlightColor: Colors.greenAccent,
                          onDone: (text) async {
                            print('_otpController');
                            // await authService.signinWithPhoneNumber(
                            //     verificationIdFinal,
                            //     _otpController.text,
                            //     context);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen()),
                                (route) => false);
                          },

                          defaultBorderColor: ColorApp.secondaryText,
                          hasTextBorderColor: ColorApp.primary,
                          pinBoxRadius: 5.0,
                          pinBoxHeight: 40,
                          pinBoxWidth: 40,
                          isCupertino: true,
                          pinTextStyle: TextStyle(fontSize: 18),
                        ),
                      ),
                      Text(
                        'Если долго не приходит код - проверьте правильно ли указан номер телефона',
                        style: TextStyle(
                            fontSize: 12, color: ColorApp.secondaryText),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
      // print(verificationIdFinal);
    });
  }
}
