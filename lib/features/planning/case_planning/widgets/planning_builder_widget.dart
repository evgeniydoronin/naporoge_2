import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../../components/constants.dart';
import '../presentation/provider/cell_provider.dart';

Map<String, dynamic> globalSelectedCells = {};
Map<String, dynamic> tempSelectedCells = {};
bool dayCellEnabled = true;

enum CellType { period, workweek, sunday }

enum DayType { morning, afternoon, evening }

class PeriodOfTheDay {
  PeriodOfTheDay({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
    required this.periodRows,
    required this.startHour,
    required this.panelIndex,
  });

  DayType expandedValue;
  String headerValue;
  bool isExpanded;
  int periodRows;
  int startHour;
  int panelIndex;
}

List<PeriodOfTheDay> generateItems(int numberOfItems) {
  return <PeriodOfTheDay>[
    PeriodOfTheDay(
      headerValue: 'Утро',
      expandedValue: DayType.morning,
      periodRows: 8,
      startHour: 4,
      panelIndex: 0,
    ),
    PeriodOfTheDay(
      headerValue: 'День',
      expandedValue: DayType.afternoon,
      periodRows: 7,
      startHour: 12,
      panelIndex: 1,
    ),
    PeriodOfTheDay(
      headerValue: 'Вечер',
      expandedValue: DayType.evening,
      periodRows: 8,
      startHour: 19,
      panelIndex: 2,
    ),
  ];
}

List<String> weekDay = [
  'пн',
  'вт',
  'ср',
  'чт',
  'пт',
  'сб',
  'вс',
];

class PlannerBuilder extends StatefulWidget {
  const PlannerBuilder({super.key});

  @override
  State<PlannerBuilder> createState() => _PlannerBuilderState();
}

class _PlannerBuilderState extends State<PlannerBuilder> {
  final List<PeriodOfTheDay> periodOfTheDay = generateItems(3);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 15, left: 15),
            child: Text(
              'Неделя 1/3',
              style: TextStyle(fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 2, left: 15, bottom: 10),
            child: Text(
              '1 декабря - 13 декабря',
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.left,
            ),
          ),
          Row(
            children: [
              Container(
                width: 70,
                padding: EdgeInsets.only(left: 15),
                child: SvgPicture.asset(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.fitHeight,
                  clipBehavior: Clip.none,
                  'assets/icons/time.svg',
                  color: ColorApp.primary,
                ),
              ),
              Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    itemCount: 7,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 7),
                    itemBuilder: (BuildContext ctx, gridIndex) {
                      return Center(
                          child: Text(
                        weekDay[gridIndex].toUpperCase(),
                        style: TextStyle(color: ColorApp.primary),
                      ));
                    }),
              ),
            ],
          ),
          Container(
            child: _buildPanel(),
          ),
        ],
      ),
    );
  }

  ExpansionPanelList _buildPanel() {
    return ExpansionPanelList(
      elevation: 1,
      dividerColor: ColorApp.secondaryText,
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          periodOfTheDay[index].isExpanded = !isExpanded;
        });
      },
      children: periodOfTheDay.map<ExpansionPanel>((PeriodOfTheDay item) {
        return ExpansionPanel(
          canTapOnHeader: true,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: Container(
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: ColorApp.lightGrey)),
              ),
              child: RowHoursPeriodBuilder(item: item)),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class RowHoursPeriodBuilder extends StatefulWidget {
  final PeriodOfTheDay item;
  const RowHoursPeriodBuilder({Key? key, required this.item}) : super(key: key);

  @override
  State<RowHoursPeriodBuilder> createState() => _RowHoursPeriodBuilderState();
}

class _RowHoursPeriodBuilderState extends State<RowHoursPeriodBuilder> {
  double dayPeriodCellWidth = 70;

  @override
  Widget build(BuildContext context) {
    dayCellEnabled = context.watch<CellProvider>().dayCellEnabled;
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.item.periodRows,
        itemBuilder: (BuildContext context, rowIndex) {
          String hourStart = (widget.item.startHour + rowIndex).toString();
          String hourFinished = '';
          if (int.parse(hourStart) < 9) {
            hourStart = '0$hourStart';
            hourFinished =
                '0${(widget.item.startHour + rowIndex + 1).toString()}';
          } else if (int.parse(hourStart) == 9) {
            hourStart = '0$hourStart';
            hourFinished = (widget.item.startHour + rowIndex + 1).toString();
          } else if (int.parse(hourStart) >= 10 && int.parse(hourStart) < 23) {
            hourFinished = (widget.item.startHour + rowIndex + 1).toString();
          } else if (int.parse(hourStart) == 23) {
            hourFinished = '00';
          } else if (int.parse(hourStart) > 23) {
            hourStart = '0${(rowIndex - 5).toString()}';
            hourFinished = '0${(rowIndex - 4).toString()}';
          }

          return LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              height: 41,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    width: dayPeriodCellWidth,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          top: BorderSide(color: ColorApp.lightGrey),
                        )),
                    child: Center(
                        child: Text(
                      '$hourStart - $hourFinished',
                      style: TextStyle(
                          color: ColorApp.secondaryText, fontSize: 12),
                    )),
                  ),
                  Expanded(
                    child: GridBuilder(
                        item: widget.item,
                        rowIndex: rowIndex,
                        dayPeriodCellWidth: dayPeriodCellWidth,
                        constraints: constraints,
                        dayCellEnabled: dayCellEnabled),
                  ),
                  // _gridBuilder(item, rowIndex, constraints),
                ],
              ),
            );
          });
        });
  }
}

class GridBuilder extends StatefulWidget {
  final PeriodOfTheDay item;
  final int rowIndex;
  final double dayPeriodCellWidth;
  final BoxConstraints constraints;
  final bool dayCellEnabled;
  const GridBuilder(
      {Key? key,
      required this.item,
      required this.rowIndex,
      required this.constraints,
      required this.dayPeriodCellWidth,
      required this.dayCellEnabled})
      : super(key: key);

  @override
  State<GridBuilder> createState() => _GridBuilderState();
}

class _GridBuilderState extends State<GridBuilder> {
  @override
  Widget build(BuildContext context) {
    PeriodOfTheDay item = widget.item;
    int rowIndex = widget.rowIndex;
    double dayPeriodCellWidth = widget.dayPeriodCellWidth;
    BoxConstraints constraints = widget.constraints;
    Planner planner = Planner(globalSelectedCells: globalSelectedCells);

    dayCellEnabled = context.watch<CellProvider>().dayCellEnabled;

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 7,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 7,
        itemBuilder: (BuildContext context, gridIndex) {
          bool isSundayCell = gridIndex == 6;
          // print('dayCellEnabled: $dayCellEnabled');

          if (isSundayCell) {
            return Container(
              foregroundDecoration: const BoxDecoration(
                  border: Border(
                top: BorderSide(color: ColorApp.lightGrey),
              )),
              decoration: BoxDecoration(color: ColorApp.primary.withAlpha(20)),
              child: const SizedBox(),
            );
          } else {
            return GestureDetector(
              onDoubleTap: () {
                print('globalSelectedCells: $globalSelectedCells');
                planner.removeCell('${item.panelIndex}.$rowIndex.$gridIndex');
                print('globalSelectedCells: $globalSelectedCells');
                context.read<CellProvider>().removeGlobalSelectedCell(
                    '${item.panelIndex}.$rowIndex.$gridIndex');
              },
              onTapDown: null,
              onTapUp: null,
              onTap: dayCellEnabled
                  ? () {
                      setState(() {
                        tempSelectedCells[
                            '${item.panelIndex}.$rowIndex.$gridIndex'] = '';
                      });
                      context.read<CellProvider>().changeCellEnabled(false);

                      _dialogBuilder(
                          item, context, rowIndex, tempSelectedCells);
                    }
                  : null,
              onLongPressEnd: (LongPressEndDetails details) {
                _dialogBuilder(item, context, rowIndex, tempSelectedCells);
              },
              onLongPressMoveUpdate: (LongPressMoveUpdateDetails details) {
                int cellPadding = 1;
                int cellWidth =
                    ((constraints.biggest.width - dayPeriodCellWidth) / 7)
                        .floor();
                int globalHorizontalPosition =
                    (details.globalPosition.dx).floor();

                for (int i = 0; i < 6; i++) {
                  int index = i + 1;
                  int min = cellWidth * i;
                  int max = cellWidth * index;

                  if (i == 0) {
                    if (globalHorizontalPosition - dayPeriodCellWidth <
                        cellWidth + cellPadding) {
                      setState(() {
                        tempSelectedCells['${item.panelIndex}.$rowIndex.$i'] =
                            '';
                      });
                    }
                  } else {
                    if (globalHorizontalPosition - dayPeriodCellWidth >
                            min + cellPadding &&
                        globalHorizontalPosition - dayPeriodCellWidth <=
                            max - cellPadding) {
                      setState(() {
                        tempSelectedCells['${item.panelIndex}.$rowIndex.$i'] =
                            '';
                      });
                    } else if (globalHorizontalPosition - dayPeriodCellWidth <=
                        max - cellPadding) {
                      setState(() {
                        tempSelectedCells
                            .remove('${item.panelIndex}.$rowIndex.$i');
                      });
                    }
                  }
                }
              },
              child: Container(
                foregroundDecoration: const BoxDecoration(
                    border: Border(
                  top: BorderSide(color: ColorApp.lightGrey),
                  left: BorderSide(color: ColorApp.lightGrey),
                )),
                color: getColorCell(item, rowIndex, gridIndex, context),
                child: getCellData(item, rowIndex, gridIndex, context),
                // child: Text(cellData != null ? cellData.minute.toString() : ''),
              ),
            );
          }
        });
  }
}

Column getCellData(item, rowIndex, gridIndex, context) {
  String time = '';
  if (globalSelectedCells.keys
      .contains('${item.panelIndex}.$rowIndex.$gridIndex')) {
    time = globalSelectedCells['${item.panelIndex}.$rowIndex.$gridIndex'];
  }

  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        time,
        style: TextStyle(fontSize: 12),
      ),
    ],
  );
}

Color getColorCell(item, rowIndex, gridIndex, context) {
  return tempSelectedCells.isNotEmpty
      ? tempSelectedCells.keys
              .contains('${item.panelIndex}.$rowIndex.$gridIndex')
          ? ColorApp.lightGrey
          : Colors.white
      : globalSelectedCells.keys
              .contains('${item.panelIndex}.$rowIndex.$gridIndex')
          ? ColorApp.lightGrey
          : Colors.white;
}

void _dialogBuilder(PeriodOfTheDay item, BuildContext context, rowIndex,
    tempSelectedCells) async {
  DateTime initialDate = DateTime.now();
  int _hour = (item.startHour + rowIndex).toInt();

  DateTime initialHour =
      DateTime(initialDate.year, initialDate.month, initialDate.day, _hour, 00);

  DateTime newDate = initialHour;

  Planner planner = Planner(
      tempSelectedCells: tempSelectedCells,
      globalSelectedCells: globalSelectedCells);

  List<int> defaultMinutes = List.generate(12, (index) => (index * 5));
  List<Widget> defaultMinutesText =
      List.generate(12, (index) => Text('${index * 5}'));

  switch (_hour) {
    case 24:
      _hour = 0;
      break;
    case 25:
      _hour = 1;
      break;
    case 26:
      _hour = 2;
      break;
  }

  String newCellTimeString = '$_hour:00';

  print(tempSelectedCells);

  return showDialog<void>(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext ctx) {
      return AlertDialog(
        // title: Text('Row index $rowIndex $_hour'),
        content: SizedBox(
          height: 150,
          child: CupertinoTheme(
            data: const CupertinoThemeData(
              textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(fontSize: 26),
              ),
            ),
            //Text('Cell indexes ${selectedIds.toString()}')
            // child: CupertinoDatePicker(
            //   // initialDateTime: DateTime.now().add(
            //   //   Duration(hours: min, minutes: 5 - DateTime.now().minute % 5),
            //   // ),
            //   initialDateTime: initialHour,
            //   mode: CupertinoDatePickerMode.time,
            //   use24hFormat: true,
            //   minuteInterval: 5,
            //   minimumDate: initialHour,
            //   maximumDate: maxHour,
            //   onDateTimeChanged: (DateTime _newDate) {
            //     newDate = _newDate;
            //     // print('newDate: $newDate');
            //   },
            // ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$_hour',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  width: 100,
                  child: CupertinoPicker(
                      itemExtent: 26,
                      onSelectedItemChanged: (index) {
                        newCellTimeString = DateFormat('Hm').format(DateTime(
                            initialDate.year,
                            initialDate.month,
                            initialDate.day,
                            _hour,
                            defaultMinutes[index]));
                      },
                      children: defaultMinutesText),
                ),
              ],
            ),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        insetPadding: EdgeInsets.zero,
        actions: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text(
                  'Отмена',
                  style: TextStyle(color: ColorApp.secondaryText),
                ),
                onPressed: () {
                  planner.clearTempSelectedIndexes();
                  context.read<CellProvider>().changeCellEnabled(true);
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('OK'),
                onPressed: () {
                  context.read<CellProvider>().changeCellData(newDate);
                  context.read<CellProvider>().changeCellEnabled(true);

                  print(globalSelectedCells);
                  print(newCellTimeString);

                  // если глобальных данных нет
                  if (globalSelectedCells.isEmpty) {
                    globalSelectedCells =
                        planner.setCellData(true, newCellTimeString);
                  } else {
                    globalSelectedCells =
                        planner.setCellData(false, newCellTimeString);
                  }
                  planner.clearTempSelectedIndexes();

                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      );
    },
  );
}

class Planner {
  final Map<String, dynamic>? tempSelectedCells;
  final Map<String, dynamic>? globalSelectedCells;

  Planner({
    this.tempSelectedCells,
    this.globalSelectedCells,
  });

  void removeCell(key) {
    globalSelectedCells!.remove(key);
  }

  void clearTempSelectedIndexes() {
    tempSelectedCells!.clear();
  }

  Map<String, dynamic> setCellData(bool isFirstSelect, String newDate) {
    Map<String, dynamic> newGlobalSelectedCells = {};

    if (isFirstSelect) {
      tempSelectedCells!.updateAll((key, value) => value = newDate);
      newGlobalSelectedCells = Map<String, dynamic>.from(tempSelectedCells!);
    } else {
      // Ячейки для удаления
      Set<String> prepareDeleteSelectedCells = {};

      final tempSelectedKeys = Set<String>.from(tempSelectedCells!.keys);
      final globalSelectedKeys = Set<String>.from(globalSelectedCells!.keys);

      // 1. Подготовка ячеек для удаления
      for (var oldCell in globalSelectedKeys) {
        for (var newCell in tempSelectedKeys) {
          if (oldCell.split('.')[2] == newCell.split('.')[2]) {
            prepareDeleteSelectedCells.add(oldCell);
          }
        }
      }

      // 2. Удаляем из globalSelectedCells пересечение
      globalSelectedCells!.removeWhere(
          (key, value) => prepareDeleteSelectedCells.contains(key));

      // 3. Обновляем инфу в новых ячейках
      tempSelectedCells!.updateAll((key, value) => value = newDate);

      // 4. Объединяем старые и новые ячейки
      newGlobalSelectedCells = {...globalSelectedCells!, ...tempSelectedCells!};
    }

    return newGlobalSelectedCells;
  }
}
