import 'package:flutter/material.dart';
import '../../../../components/constants.dart';
import '../../../planning/first_planning/presentation/first_planning_screen.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  int _currentPage = 0;

  final PageController _pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text('Правила работы'),
      ),
      body: Container(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        decoration: const BoxDecoration(color: Colors.white),
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            PageView.builder(
              controller: _pageController,
              itemCount: slideList.length,
              onPageChanged: _onPageChanged,
              itemBuilder: (ctx, i) => SlideItem(i),
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  bottom: -5,
                  child: Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 5),
                    height: 37,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        for (int i = 0; i < slideList.length; i++)
                          if (i == _currentPage)
                            const SlideDots(true)
                          else
                            const SlideDots(false)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  final int index;

  const SlideItem(this.index, {super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          child: slideList[index].title,
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

class RuleSlide {
  final Widget title;

  RuleSlide(this.title);
}

final slideList = [
  RuleSlide(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Важно правильно выбрать Дело!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''
Дело нужно будет регулярно выполнять в течение нескольких недель. Дело должно быть явно полезным. И это должно быть такое Дело, которое и желается, но и, почему-то, так и не делается (не делалось). Дело должно быть новым, непривычным. Легкое и приятное дело не подойдет.
Дело должно быть вполне выполнимым («посильным»). Вы должны реально понимать, что ничто (кроме чрезвычайного) не может помешать Вам его сделать.
Предлагаются на выбор четыре Дела: «Утренняя пробежка», «Физические упражнения (иные)», «Подведение итогов дня» и «Другое дело».      
        ''',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Планирование',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Выполнение Дела надо планировать на каждую предстоящую неделю.  Заранее.',
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  ),
  RuleSlide(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Минимум выполнения',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''
В плане требуется определить время начала выполнения Дела (например, час, в котором хотите приступить к делу).
.А также «объем» его выполнения. Этот объем нужно стараться обязательно выполнять. Все, что делается свыше этого, – идет как бонус для себя.
В зависимости от Дела устанавливается продолжительность (пробежки и т.п.), либо объем действий (отжиманий, подтягиваний…).
При определении количественного объема выполнения Дела нужно ориентироваться на «минимум - 15 минут» (исключение – Итоги дня).
Это минимум. Выделяйте время так, чтобы получили пользу от Дела.
Пример: среда, с 20 часов читать «…» 30 минут.      
        ''',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Воскресенья!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'В данном курсе Дело выполняется 6 дней в неделю. Воскресенье остается в виде резерва – для того, чтобы можно было выполнить Дело, не сделанное в свой плановый день, осмыслить ход работы.',
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  ),
  RuleSlide(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Учёт выполнения дела',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''
Важно вести учет выполнения Дел. Отмечайте в % (так, как сами это ощущаете):
- объем выполнения Дела;
- силу нежеланий приступать к Делу и выполнять его;
- силу желаний приступать к Делу;
- отмечайте сразу (чтобы не забылись) и другие важные факты.
ВАЖНО!  Отмечать результаты выполнения НАДО в тот день, когда выполнялось дело. Если такой отметки не будет, дело фиксируется как невыполненное.        
        ''',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Дневник',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''
Рекомендуем вести «Дневник» и фиксировать в нем
- что сбивало, мешало выполнять план и даже побуждало забросить  данный курс;
- настроения и мысли, которые вас поддерживали и воодушевляли;
- важные идеи по улучшению самоорганизации и жизни в целом.
Дневник вести непривычно и трудно.
Но именно формулирование мыслей помогает выявлять и помнить сбивающие факторы.
Опыт показывает - если не фиксировать факты, многие из них забываются.     
        ''',
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  ),
  RuleSlide(
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text(
          'Главные условия успеха',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''
- иметь четкий план выполнения Дела
- выполнять Дело и выявлять. что этому мешает
- в день выполнения Дела отмечать результаты        
        ''',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 40,
        ),
        Text(
          'Важно!',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          '''
Рекомендуем использовать опцию «Перечень важных дел» - смотрите раздел Дополнительное.  
        ''',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(
          height: 60,
        ),
        StartFirstPlanning(),
      ],
    ),
  ),
];

class StartFirstPlanning extends StatelessWidget {
  const StartFirstPlanning({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 60),
        shape: const RoundedRectangleBorder(borderRadius: primaryRadius),
      ),
      onPressed: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const FirstPlanningScreen()),
            (route) => false); // first_planning
      },
      child: const Text(
        'Продолжить',
        style: TextStyle(fontSize: buttonTextSize),
      ),
    );
  }
}

class SlideDots extends StatelessWidget {
  final bool isActive;

  const SlideDots(this.isActive, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: isActive ? 12 : 8,
      width: isActive ? 12 : 8,
      decoration: BoxDecoration(
        color: isActive ? ColorApp.primary : ColorApp.secondaryText,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}
