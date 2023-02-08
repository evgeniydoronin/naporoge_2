import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../components/constants.dart';
// import 'package:naporoge/config/routes.dart';
import 'package:video_player/video_player.dart';

import 'rules_screen.dart';

class SchemeRuleScreen extends StatefulWidget {
  const SchemeRuleScreen({Key? key}) : super(key: key);

  @override
  State<SchemeRuleScreen> createState() => _SchemeRuleScreenState();
}

class _SchemeRuleScreenState extends State<SchemeRuleScreen> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;
  bool isPlay = false;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.network(RemoteAssets().videoAssets() + '/1.mp4');

    videoPlayerController.initialize().then((_) {
      setState(() {});
    });

    chewieController = ChewieController(
      showOptions: false,
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
    );

    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.

    videoPlayerController.dispose();
    chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const Text(
              'Схема работы',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '''
1. Выбрать из предложенных вариантов или свободно подобрать развивающее дело

2. Составлять недельные планы выполнения дела

3. Стараться делать его и запоминать возникающие нежелания приступать к делу, желание отложить его и иные мешающие факторы

4. В день выполнения дела отмечать объем выполнения и мешающие факторы

5. На основе своих размышлений и с помощью видео тренировать умение четко выполнять намеченные дела – независимо от перепадов настроений
            ''',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(15),
                ),
                // color: Colors.yellowAccent,
              ),
              child: isPlay
                  ? Chewie(controller: chewieController)
                  : FittedBox(
                      fit: BoxFit.contain,
                      child: ClipRRect(
                        borderRadius: primaryRadius,
                        child: Stack(
                          children: [
                            Image.asset('assets/images/1.png'),
                            Positioned(
                              top: 0,
                              bottom: 0,
                              right: 0,
                              left: 0,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    chewieController = ChewieController(
                                      aspectRatio: 16 / 9,
                                      autoPlay: true,
                                      showOptions: false,
                                      videoPlayerController:
                                          VideoPlayerController.network(
                                              RemoteAssets().videoAssets() +
                                                  '/1.mp4'),
                                      deviceOrientationsAfterFullScreen: [
                                        DeviceOrientation.portraitUp,
                                      ],
                                    );
                                    isPlay = true;
                                  });
                                },
                                icon: const Icon(
                                  Icons.play_circle_fill_sharp,
                                  size: 80,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
            const SizedBox(
              height: 40,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape:
                    const RoundedRectangleBorder(borderRadius: primaryRadius),
              ),
              onPressed: () {
                chewieController.pause();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RulesScreen()));
              },
              child: const Text(
                'Продолжить',
                style: TextStyle(fontSize: buttonTextSize),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
