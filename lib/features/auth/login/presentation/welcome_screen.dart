import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:video_player/video_player.dart';

import '../../../../components/constants.dart';
import '../../registration/presentation/activate_account_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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
    videoPlayerController.dispose();
    chewieController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
        decoration: const BoxDecoration(color: ColorApp.primary),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            SvgPicture.asset('assets/icons/wellcome.svg'),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Поздравляем!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Вы зашли в пространство саморазвития',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text(
              '''
  В 2014 мы – студенты-психологи
  создали его для собственного развития
  И продвинули себя!
  Знаем, что делаем!
                    ''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              height: 40,
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
                            Image.asset('assets/images/placeholder.png'),
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
              onPressed: () async {
                setState(() {
                  chewieController.pause();
                });
                // await FirebaseAuth.instance.signOut();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ActivateAccountScreen()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 60),
                shape:
                    const RoundedRectangleBorder(borderRadius: primaryRadius),
              ),
              child: const Text(
                'Продолжить',
                style: TextStyle(
                    fontSize: buttonTextSize, color: ColorApp.primary),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
