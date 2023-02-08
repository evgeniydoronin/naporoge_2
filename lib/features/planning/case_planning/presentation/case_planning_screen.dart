// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
// import 'package:naporoge/config/constants.dart';
// import 'package:naporoge/domain/date/week_number.dart';
// import 'package:naporoge/domain/planning/first_planning.dart';
// import 'package:naporoge/pages/dashboard/dashboard.dart';
// import 'package:naporoge/pages/planning/view/first_planning_page.dart';
import 'package:provider/src/provider.dart';

import '../../../../components/constants.dart';
import '../../first_planning/presentation/first_planning_screen.dart';
import '../../first_planning/presentation/provider/first_planning_provider.dart';
import '../widgets/planning_builder_widget.dart';

class CasePlanningScreen extends StatefulWidget {
  final PageController pageController;
  const CasePlanningScreen({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  _CasePlanningScreenState createState() => _CasePlanningScreenState();
}

class _CasePlanningScreenState extends State<CasePlanningScreen> {
  final _formKeyLast = GlobalKey<FormState>();
  final TextEditingController _courseDescriptionController =
      TextEditingController();

  late DateTime initialDate;
  // late CalendarDataSource _dataSource;
  late DateTime _startDataCourse;
  late int _weeks;
  int _courseWeekNumber = 1;
  late DateTime _minDate;
  late DateTime _maxDate;
  late bool _isActivated;
  // late CalendarController _calendarController;

  // ConnectivityResult? _connectivityResult;

  // @override
  // void initState() {
  //   super.initState();
  //
  //   _isActivated = false;
  //
  //   DateTime initial = DateTime.now();
  //   initialDate =
  //       DateTime(initial.year, initial.month, initial.day, initial.hour, 0);
  //
  //   String _m = DateFormat('m', 'ru_RU').format(DateTime.parse(
  //       context.read<FirstPlanning>().getCourseTimeFirstDayStart.toString()));
  //   String H = DateFormat('H', 'ru_RU').format(DateTime.parse(
  //       context.read<FirstPlanning>().getCourseTimeFirstDayStart.toString()));
  //   String _d = DateFormat('dd', 'ru_RU')
  //       .format(DateTime.parse(
  //           context.read<FirstPlanning>().caseDateStart.toString()))
  //       .toString();
  //   String MM = DateFormat('MM', 'ru_RU')
  //       .format(DateTime.parse(
  //           context.read<FirstPlanning>().caseDateStart.toString()))
  //       .toString();
  //   String _y = DateFormat('y', 'ru_RU')
  //       .format(DateTime.parse(
  //           context.read<FirstPlanning>().caseDateStart.toString()))
  //       .toString();
  //
  //   _startDataCourse = DateTime(int.parse(_y), int.parse(MM), int.parse(_d),
  //       int.parse(H), int.parse(_m));
  //
  //   _minDate =
  //       DateTime(int.parse(_y), int.parse(MM), int.parse(_d), 0, 0, 0, 0, 0);
  //
  //   _maxDate = _minDate
  //       .add(const Duration(days: 20, hours: 23, minutes: 59, seconds: 59));
  //
  //   _weeks = 3; // * 7 = 21
  //   int _courceLength = _weeks * 7; // в днях
  //
  //   _dataSource = _getCalendarDataSource(_startDataCourse, _courceLength);
  //   _calendarController = CalendarController();
  // }
  //
  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is removed from the
  //   // widget tree.
  //   // _courseDescriptionController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKeyLast,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView(
          children: [
            StepperIcons(step: 2),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                border: Border.all(width: 1, color: ColorApp.primary),
              ),
              child: Text(
                'Йога',
                style: TextStyle(color: ColorApp.primary, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: ColorApp.primary,
              ),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  Text(
                    'Физические упражнения (иные)',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'Минимум 15 минут',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Text('Моя задача:'),
            SizedBox(height: 5),
            TextFormField(
              controller: _courseDescriptionController,
              // The validator receives the text that the user has entered.
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Заполните обязательное поле!';
                }
                return null;
              },
              maxLines: 2,
              maxLength: 200,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                hintText: 'Укажите объем выполнения и цель дела',
                hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
                labelStyle: TextStyle(color: Colors.grey, fontSize: 12),
                fillColor: Color(0xffF2F2F2),
                filled: true,
                errorBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.redAccent),
                    borderRadius: primaryRadius),
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: primaryRadius),
                focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.transparent),
                    borderRadius: primaryRadius),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Скорректируйте время по дням, если необходимо',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: EdgeInsets.only(bottom: 10),
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: primaryRadius,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: PlannerBuilder(),
              ),
            ),
            SizedBox(height: 10),
            Text('Осталось запланировать: 6 дней'),
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: primaryRadius)),
              onPressed: () async {
                // Navigator.pushAndRemoveUntil(
                //     context,
                //     MaterialPageRoute(builder: (context) => MyDashBoard()),
                //         (route) => false);
              },
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'План мне подходит',
                  style: TextStyle(fontSize: buttonTextSize),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
