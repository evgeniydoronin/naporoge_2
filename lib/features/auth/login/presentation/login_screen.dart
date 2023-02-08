import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import '../../../../components/constants.dart';
import 'login_phone_confirm_screen.dart';
import 'privacy_policy_screen.dart';
import 'personal_data_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final maskFormatter = MaskTextInputFormatter(mask: '+7 (###) ###-##-##');
  bool _isActiveBtn = false;
  bool _isChecked = false;

  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Timer? _timer;
  int _start = 60;
  bool _isTimerStart = false;

  List<int> errorScreen = [];

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            _isTimerStart = false;
          } else {
            _isTimerStart = true;
            _start = _start - 1;
            // print(_start);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    errorScreen.add(1);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(errorScreen.length);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Вход',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Доступ к вашему аккаунту и личным заметкам имеете только вы.  Доступа к вашей информации для других нет.',
                    style: TextStyle(
                      color: ColorApp.secondaryText,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          // enabled: false,
                          controller: phoneController,
                          decoration: const InputDecoration(
                            floatingLabelStyle: TextStyle(
                              fontSize: 18.0,
                              color: ColorApp.secondaryText,
                            ),
                            filled: true,
                            fillColor: ColorApp.disableInputField,
                            contentPadding: EdgeInsets.only(
                                right: 25.0,
                                left: 25.0,
                                top: 20.0,
                                bottom: 20.0),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.secondaryText,
                                width: 2,
                              ),
                              borderRadius: primaryRadius,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: ColorApp.primary,
                                width: 2,
                              ),
                              borderRadius: primaryRadius,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: primaryRadius,
                              borderSide: BorderSide(
                                color: ColorApp.primary,
                                width: 2,
                              ),
                            ),
                            labelText: 'Телефон',
                            labelStyle: TextStyle(fontSize: 14.0),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [maskFormatter],
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              // print(value);
                              return 'Введите номер телефона!';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 60),
                            shape: const RoundedRectangleBorder(
                                borderRadius: primaryRadius),
                          ),
                          onPressed: errorScreen.isEmpty
                              ? _isTimerStart
                                  ? null
                                  : () {
                                      if (_formKey.currentState!.validate()) {
                                        // print('object');
                                        startTimer();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                LoginPhoneConfirmScreen(
                                              phone: maskFormatter
                                                  .getUnmaskedText(),
                                            ),
                                          ),
                                        );
                                      }
                                    }
                              : null,
                          child: _isTimerStart
                              ? Text(
                                  'Отправить через $_start секунд',
                                  style:
                                      const TextStyle(fontSize: buttonTextSize),
                                )
                              : const Text(
                                  'Отправить код',
                                  style: TextStyle(fontSize: buttonTextSize),
                                ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Divider(
                          color: ColorApp.secondaryText,
                          height: 20,
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              _isChecked = !_isChecked;
                              if (_isChecked) {
                                _isActiveBtn = true;
                                errorScreen.remove(1);
                              } else {
                                errorScreen.add(1);
                                _isActiveBtn = false;
                              }
                            });
                          },
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: _isChecked
                                  ? SvgPicture.asset(
                                      'assets/icons/checkbox_on.svg')
                                  : SvgPicture.asset(
                                      'assets/icons/checkbox_off.svg')),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: RichText(
                            text: TextSpan(
                              style: const TextStyle(
                                  color: ColorApp.secondaryText, height: 1.5),
                              children: [
                                const TextSpan(text: 'Я принимаю условия '),
                                TextSpan(
                                  text: 'политики конфидециальности',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const PrivacyPolicyScreen())),
                                  style:
                                      const TextStyle(color: ColorApp.primary),
                                ),
                                const TextSpan(text: ' и даю согласие на '),
                                TextSpan(
                                    text: 'обработку персональных данных',
                                    style: const TextStyle(
                                        color: ColorApp.primary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) =>
                                                  const PersonalDataScreen()))),
                              ],
                            ),
                          ),
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
