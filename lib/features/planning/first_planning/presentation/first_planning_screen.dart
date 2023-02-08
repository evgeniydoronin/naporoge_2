import 'package:app_v2/features/planning/start_date_selection/presentation/provider/start_day_selection_provider.dart';
import 'package:app_v2/features/planning/widgets/select_week_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../../components/constants.dart';
import '../../case_planning/presentation/case_planning_screen.dart';
import '../../choice_of_case/presentation/choice_of_case_screen.dart';
import '../../start_date_selection/presentation/start_date_selection_screen.dart';

class FirstPlanningScreen extends StatefulWidget {
  const FirstPlanningScreen({Key? key}) : super(key: key);

  @override
  State<FirstPlanningScreen> createState() => _FirstPlanningScreenState();
}

class _FirstPlanningScreenState extends State<FirstPlanningScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late PageController _pageController;
  late String _stepAppBarTitle;
  late Widget _stepDrawerData;
  var _currPageValue = 0.0;
  dynamic _leading;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    _stepAppBarTitle = 'Выбор даты старта';
    _stepDrawerData = drawerFirstPlanning1();
    _leading = _getLeading(0);
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final List<Course> _courses = Course.generateDeal();

    // // Map<String, dynamic> formData = {
    // //   'startCourseDate': '',
    // // };

    // // for (int i = 0; i < _courses.length; i++) {
    // //   formData[_courses[i].courseId] = {
    // //     'shortTitle': 'Краткое название',
    // //     'startCourseTime': DateTime.now()
    // //   };
    // // }

    // print(formData);

    return Scaffold(
      key: _scaffoldKey,
      endDrawer: _stepDrawerData,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: Text(_stepAppBarTitle),
        leading: _leading,
        actions: [
          _pageController.hasClients
              ? IconButton(
                  icon: const Icon(Icons.info_outline_rounded),
                  color: ColorApp.primary,
                  onPressed: () {
                    _scaffoldKey.currentState!.openEndDrawer();
                  },
                )
              : const SizedBox(),
        ],
      ),
      body: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: ColorApp.primary),
          canvasColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.white,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                // print(value);
                _stepAppBarTitle = _getTitleAppBar(value);
                _leading = _getLeading(value);
                if (value == 1) {
                  // openEndDrawer by default
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scaffoldKey.currentState?.openEndDrawer();
                  });
                  _stepDrawerData = drawerFirstPlanning2();
                } else if (value == 2) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    _scaffoldKey.currentState?.openEndDrawer();
                  });
                  _stepDrawerData = drawerFirstPlanning3();
                }
              });
            },
            children: [
              StartDateSelectionScreen(pageController: _pageController),
              ChoiceOfCase(pageController: _pageController),
              CasePlanningScreen(pageController: _pageController),
            ],
          ),
        ),
      ),
    );
  }

  _getLeading(step) {
    return IconButton(
      icon: const Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        // переход на следующий экран
        if (_pageController.hasClients) {
          if (step == 0) {
            Navigator.pop(context);
          } else if (step == 1) {
            _pageController.animateToPage(
              0,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
            );
          } else if (step == 2) {
            _pageController.animateToPage(
              1,
              duration: const Duration(milliseconds: 10),
              curve: Curves.easeInOut,
            );
          }
        }
      },
    );
  }

  Widget drawerFirstPlanning1() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: ColorApp.primary,
      width: double.maxFinite,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Пояснения',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              IconButton(
                iconSize: 28,
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '''
Важно выбрать дело, которое вам действительно нужно и хочется. При этом дело должно быть новым, непривычным

Затем надо выбрать время начала дела для 1-го дня 1-го недельного плана.
Укажите время начала дела точно (час и минуты) - если можете. Или укажите час, в котором хотите приступить к делу

Выбранное время автоматически продублируется на все остальные дни плана

Время начала Дела можно менять во вкладке “Планирование”.
Время лучше указывать как можно точнее. Час и минуты или час

Важно! Редактировать план можно только до начала очередной недели''',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget drawerFirstPlanning2() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: ColorApp.primary,
      width: double.maxFinite,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Пояснения',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              IconButton(
                iconSize: 28,
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            '''
Важно выбрать дело, которое вам действительно нужно и хочется. При этом дело должно быть новым, непривычным

Затем надо выбрать время начала дела для 1-го дня 1-го недельного плана.
Укажите время начала дела точно (час и минуты) - если можете. Или укажите час, в котором хотите приступить к делу

Выбранное время автоматически продублируется на все остальные дни плана

Время начала Дела можно менять во вкладке “Планирование”.
Время лучше указывать как можно точнее. Час и минуты или час

Важно! Редактировать план можно только до начала очередной недели''',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ],
      ),
    );
  }

  Widget drawerFirstPlanning3() {
    return Container(
      padding: const EdgeInsets.all(30),
      color: ColorApp.primary,
      width: double.maxFinite,
      child: ListView(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Text(
                'Пояснения',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              IconButton(
                iconSize: 28,
                color: Colors.white,
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white))),
            child: const Text(
              '1. Укажите время начала дела точно (час и минуты) - если можете. Если это трудно, укажите час, в котором начнете. Например,  7:00.',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white))),
            child: const Text(
              '2. Четко определите объем дела – продолжительность или другой показатель. Например, количество отжиманий. Укажите цель Дела. Для чего оно нужно',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white))),
            child: const Text(
              '3. Напоминаем, что минимальная продолжительность уже задана Правилами. Это – минимум 15 минут физических нагрузок. И не менее 8 минут для подведения итогов дня',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(width: 1, color: Colors.white))),
            child: const Text(
              '4. ВАЖНО! Редактировать план можно только до начала очередной недели',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              '5. ВАЖНО! Отмечать результаты выполнения дела НАДО в тот день, когда оно выполнялось. Если такой отметки не будет, дело отмечается как невыполненное',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: const Text(
              'Это – правило работы курса. Ни заранее, ни «задним числом» внести такую отметку в программу нельзя',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          Container(
            padding: EdgeInsets.all(10),
            decoration:
                BoxDecoration(color: Colors.white, borderRadius: primaryRadius),
            child: Column(
              children: [
                Text(
                  'Значения цветовых меток в плане',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: primaryRadius,
                      ),
                      child: Text(
                        '05:30',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '- запланированно',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: primaryRadius,
                        color: ColorApp.primary,
                      ),
                      child: Text(
                        '05:30',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '- выполнено вовремя',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: primaryRadius,
                        color: ColorApp.statusDayNotDoneOnTimeBG,
                      ),
                      child: Text(
                        '05:30',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '- выполнено не вовремя',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: primaryRadius,
                        color: ColorApp.statusDayNotCompletedBG,
                      ),
                      child: Text(
                        '05:30',
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '- не выполнено',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        borderRadius: primaryRadius,
                      ),
                      child: Text(
                        '05:30',
                        style:
                            TextStyle(color: ColorApp.statusDayDoneOffPlanText),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      '- выполнено вне плана',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_getTitleAppBar(index) {
  if (index == 0) {
    return 'Выбор даты старта';
  } else if (index == 1) {
    return 'Выбрать дело';
  } else if (index == 2) {
    return 'Планирование';
  }
}

class StepperIcons extends StatefulWidget {
  final int step;
  const StepperIcons({Key? key, required this.step}) : super(key: key);

  @override
  State<StepperIcons> createState() => _StepperIconsState();
}

class _StepperIconsState extends State<StepperIcons> {
  late String _iconSrc2;
  late String _iconSrc3;
  late Color _lineColor;
  late Color _lineColor2;

  @override
  void initState() {
    super.initState();
    if (widget.step == 0) {
      _lineColor = Colors.grey[200]!;
      _lineColor2 = Colors.grey[200]!;

      _iconSrc2 = 'assets/icons/checkbox_off.svg';
      _iconSrc3 = 'assets/icons/checkbox_off.svg';
    } else if (widget.step == 1) {
      _lineColor = ColorApp.primary;
      _lineColor2 = Colors.grey[200]!;

      _iconSrc2 = 'assets/icons/checkbox_on.svg';
      _iconSrc3 = 'assets/icons/checkbox_off.svg';
    } else if (widget.step == 2) {
      _lineColor = ColorApp.primary;
      _lineColor2 = ColorApp.primary;

      _iconSrc2 = 'assets/icons/checkbox_on.svg';
      _iconSrc3 = 'assets/icons/checkbox_on.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/checkbox_on.svg'),
          Container(
            height: 1,
            width: 80,
            color: _lineColor,
          ),
          SvgPicture.asset(_iconSrc2),
          Container(
            height: 1,
            width: 80,
            color: _lineColor2,
          ),
          SvgPicture.asset(_iconSrc3),
        ],
      ),
    );
  }
}
