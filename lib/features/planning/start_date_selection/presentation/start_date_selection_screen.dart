import 'package:app_v2/features/planning/start_date_selection/presentation/provider/start_day_selection_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../components/constants.dart';
import '../../first_planning/presentation/first_planning_screen.dart';
import '../../widgets/select_week_widget.dart';

class StartDateSelectionScreen extends StatefulWidget {
  final PageController pageController;
  const StartDateSelectionScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<StartDateSelectionScreen> createState() =>
      _StartDateSelectionScreenState();
}

class _StartDateSelectionScreenState extends State<StartDateSelectionScreen> {
  final bool _isActivated = false;
  String? _buttonDate;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const StepperIcons(step: 0),
        const SizedBox(height: 20),
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: primaryRadius,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: const SelectWeekWidget(),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Старт курса – только с понедельника.'),
              Text('Выберите, с какой недели начнете'),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape:
                    const RoundedRectangleBorder(borderRadius: primaryRadius)),
            onPressed: () {
              if (widget.pageController.hasClients) {
                widget.pageController.animateToPage(
                  1,
                  duration: const Duration(milliseconds: 10),
                  curve: Curves.easeInOut,
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                _buttonDate != null ? 'Выбрать $_buttonDate' : 'Выбрать',
                style: const TextStyle(fontSize: buttonTextSize),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
