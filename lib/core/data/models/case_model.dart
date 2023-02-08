class NPCase {
  String caseId;
  bool isExpanded;
  bool isUserChoice;
  String title;
  String description;
  String minTime;
  String iconUrl;

  NPCase({
    required this.caseId,
    required this.title,
    required this.description,
    required this.minTime,
    required this.iconUrl,
    this.isExpanded = false,
    this.isUserChoice = false,
  });

  static List<NPCase> generateDeal() {
    return [
      NPCase(
          caseId: 'case_running_id',
          title: 'Утренняя пробежка',
          description: 'Минимальный объем выполнения – 15 минут',
          minTime: 'Минимум 15 минут',
          iconUrl: 'assets/icons/runner.svg'),
      NPCase(
          caseId: 'case_workout_id',
          title: 'Физические упражнения (иные)',
          description:
              'Любые желаемые и полезные для вас НОВЫЕ упражнения. Минимальный объем выполнения – 15 минут. При продолжительности дела, превышающем 15 минут, сами указывайте нужное время. Если задача связана с количеством действий, весом и т.п. (например, при отжиманиях, поднятии штанги) - тоже сами определяйте задачу',
          minTime: 'Минимум 15 минут',
          iconUrl: 'assets/icons/weight.svg'),
      NPCase(
          caseId: 'case_day_results_id',
          title: 'Подведение итогов дня',
          description: '''
Это  - вечерние осмысления прошедшего дня. Что реально полезного было сделано за день? Что было упущено или сделано некачественно? Что мешало четкому ходу дел? Что реально ценного надо сделать завтра. Как делать важные дела лучше?
И т.д.

Очень полезное дело. Воспользуйтесь ситуацией, начните его практиковать. 
Минимальный объем выполнения – 8 минут''',
          minTime: 'Минимум 8 минут',
          iconUrl: 'assets/icons/todo.svg'),
      NPCase(
          caseId: 'case_other_id',
          title: 'Другое дело',
          description:
              'Это любое другое явно полезное и новое дело, которые вы хотели бы выполнить или освоить, но пока откладывали. Минимальный объем выполнения – 15 минут. При продолжительности дела, превышающей 15 минут, указывайте нужное время. Если задача связана с объемом текста, количеством упражнений и т.п. (например, при чтении, освоении языка программирования или других курсов) тоже сами определяйте задачу',
          minTime: 'Минимум 15 минут',
          iconUrl: 'assets/icons/infinity.svg'),
    ];
  }
}

class CaseData {
  Map<String, dynamic> data = {
    'case_running_id': {
      'title': 'Утренняя пробежка',
      'description': 'Минимальный объем выполнения – 15 минут',
      'minTime': 'Минимум 15 минут',
      'iconUrl': 'assets/icons/runner.svg',
    },
    'case_workout_id': {
      'title': 'Физические упражнения (иные)',
      'description':
          'Любые желаемые и полезные для вас НОВЫЕ упражнения. Минимальный объем выполнения – 15 минут. При продолжительности дела, превышающем 15 минут, сами указывайте нужное время. Если задача связана с количеством действий, весом и т.п. (например, при отжиманиях, поднятии штанги) - тоже сами определяйте задачу',
      'minTime': 'Минимум 15 минут',
      'iconUrl': 'assets/icons/weight.svg',
    },
    'case_day_results_id': {
      'title': 'Подведение итогов дня',
      'description': '''
Это  - вечерние осмысления прошедшего дня. Что реально полезного было сделано за день? Что было упущено или сделано некачественно? Что мешало четкому ходу дел? Что реально ценного надо сделать завтра. Как делать важные дела лучше?
И т.д.

Очень полезное дело. Воспользуйтесь ситуацией, начните его практиковать. 
Минимальный объем выполнения – 8 минут''',
      'minTime': 'Минимум 8 минут',
      'iconUrl': 'assets/icons/todo.svg',
    },
    'case_other_id': {
      'title': 'Другое дело',
      'description':
          'Это любое другое явно полезное и новое дело, которые вы хотели бы выполнить или освоить, но пока откладывали. Минимальный объем выполнения – 15 минут. При продолжительности дела, превышающей 15 минут, указывайте нужное время. Если задача связана с объемом текста, количеством упражнений и т.п. (например, при чтении, освоении языка программирования или других курсов) тоже сами определяйте задачу',
      'minTime': 'Минимум 15 минут',
      'iconUrl': 'assets/icons/infinity.svg',
    },
  };

  getData(caseID) {
    return data[caseID];
  }
}
