import 'package:fast_strings/fast_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:lockie_theme/lockie_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class LandingView extends StatefulWidget {

  const LandingView({Key? key}) : super(key: key);

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> with TickerProviderStateMixin {

  // Scroll logic.
  final scrollController = ScrollController();
  var index = 0;
  var scrollIsAnimating = false;

  Map<int, double> get positions {
    return {
      0: 0,
      1: MediaQuery.of(context).size.height - 150,
      2: scrollController.position.maxScrollExtent
    };
  }

  void animateTo(int index) async {
    scrollIsAnimating = true;
    await scrollController.animateTo(positions[index]!, 
      duration: Duration(milliseconds: 1000),
      curve: Curves.easeOutQuint
    );
    scrollIsAnimating = false;
    this.index = index;
  }

  // Animation logic.
  static makeTween<T>(T begin, T end, double weight)
  => TweenSequenceItem<T>(
    tween: Tween<T>(begin: begin, end: end),
    weight: weight
  );

  late AnimationController frame2Controller;
  late AnimationController frame3Controller;

  late Animation<double> subtitle1Animation;
  late Animation<double> subtitle2Animation;
  late Animation<double> descriptionAnimation;
  late Animation<double> subtitleFadeAnimation;

  late Animation<Offset> frame3ArrowOffsetAnimation;

  @override
  void initState() {
    super.initState();

    frame2Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 3000)
    );

    frame3Controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800)
    );

    subtitle1Animation = TweenSequence<double>([
      makeTween<double>(0, 0, 20),
      makeTween<double>(0, 1, 80)
    ]).animate(CurvedAnimation(parent: frame2Controller, curve: Curves.ease));

    subtitle2Animation = TweenSequence<double>([
      makeTween<double>(0, 0, 50),
      makeTween<double>(0, 1, 50)
    ]).animate(CurvedAnimation(parent: frame2Controller, curve: Curves.ease));

    descriptionAnimation = TweenSequence<double>([
      makeTween<double>(0, 0, 80),
      makeTween<double>(0, 1, 20)
    ]).animate(CurvedAnimation(parent: frame2Controller, curve: Curves.ease));

    subtitleFadeAnimation = Tween<double>(begin: 1, end: 0.2)
    .animate(CurvedAnimation(parent: frame3Controller, curve: Curves.easeOutCubic));

    frame3ArrowOffsetAnimation = Tween<Offset>(begin: Offset(0, -1), end: Offset.zero)
    .animate(CurvedAnimation(parent: frame3Controller, curve: Curves.ease));
  }

  @override
  void dispose() {
    frame2Controller.dispose();
    frame3Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Listener(
        onPointerSignal: (event) async {
          if(event is PointerScrollEvent) {
            switch(index) {
              case 0:
                if(event.scrollDelta.dy > 10 && !scrollIsAnimating) {
                  animateTo(1);
                  if(frame2Controller.isDismissed) {
                    await frame2Controller.forward();
                    await frame3Controller.forward();
                  }
                }
                break;
              case 1:
                if(event.scrollDelta.dy < -10 && !scrollIsAnimating) {
                  animateTo(0);
                }
                if(event.scrollDelta.dy > 10 && !scrollIsAnimating) {
                  animateTo(2);
                }
                break;
              case 2:
                if(event.scrollDelta.dy < -10 && !scrollIsAnimating) {
                  animateTo(1);
                  if(frame3Controller.isCompleted) {
                    frame3Controller.value = 0;
                  }
                }
                break;
            }
          }
        },
        child: ListView(
          controller: scrollController,
          physics: NeverScrollableScrollPhysics(),
          children: [
            SizedBox(height: size.height * 0.3),
            Center(
              child: Text('Lockie.',
                style: TextStyle(
                  fontSize: 100,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            InkWell(
              child: LoopTransition(
                duration: Duration(milliseconds: 1200),
                builder: (animation, widget) 
                => FadeTransition(
                  opacity: animation.drive(Tween(begin: 0.2, end: 1)),
                  child: widget,
                ),
                child: Icon(Icons.keyboard_arrow_down_rounded, size: 36)
              ),
              onTap: () async {
                animateTo(1);
                if(frame2Controller.isDismissed) {
                  await frame2Controller.forward();
                  await frame3Controller.forward();
                }
              },
            ),
            SizedBox(height: size.height * 0.4),
            AdaptiveScreen(
              wideScreen: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Image.asset('assets/screenshot_panel.png',
                      width: 350,
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                FadeTransition(
                                  opacity: subtitle1Animation,
                                  child: FadeTransition(
                                    opacity: subtitleFadeAnimation,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text('Posh. ', 
                                        style: Theme.of(context).textTheme.headline2!
                                          .copyWith(
                                            color: Colors.white,
                                            fontFamily: 'GreatVibes',
                                            fontSize: 80
                                          )
                                      ),
                                    ),
                                  )
                                ),
                                FadeTransition(
                                  opacity: subtitle2Animation,
                                  child: FadeTransition(
                                    opacity: subtitleFadeAnimation,
                                    child: Text('Light.', 
                                      style: Theme.of(context).textTheme.headline2!
                                        .copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w100,
                                        )
                                    ),
                                  )
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                FadeTransition(
                                  opacity: descriptionAnimation,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          width: 2,
                                          color: Colors.white
                                        )
                                      )
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: Text('keeps your passwords safe.',
                                        style: Theme.of(context).textTheme.headline2!
                                          .copyWith(
                                            color: Colors.white,
                                          )
                                      ),
                                    ),
                                  )
                                ),
                                SizedBox(height: 10),
                                FadeTransition(
                                  opacity: frame3Controller,
                                  child: SlideTransition(
                                    position: frame3ArrowOffsetAnimation,
                                    child: InkWell(
                                      child: Icon(Icons.keyboard_arrow_down_rounded, 
                                        size: 36,
                                        color: Colors.white,
                                      ),
                                      onTap: () => animateTo(2),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ]
                        ),
                      )
                    )
                  ]
                )
              ),
              mobileScreen: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 30),
                    child: Image.asset('assets/screenshot_panel.png'),
                  ),
                ]
              ),
            ),
            AdaptiveScreen(
              wideScreen: Padding(
                padding: const EdgeInsets.fromLTRB(50, 300, 0, 100),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: size.width * 0.5,
                          child: Text('Download now or make your own',
                            style: Theme.of(context).textTheme.headline2!
                              .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: size.width * 0.5,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: WebText(Strings.data['description']),
                          )
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20, left: 20),
                          child: InkWell(
                            child: Image.asset('assets/github.png',
                              width: 200,
                              color: Colors.white,
                              colorBlendMode: BlendMode.srcIn,
                            ),
                            onTap: () => launchUrl(Uri.parse('https://github.com/nathanielxd/lockie')),
                          ),
                        ),
                        Image.asset('assets/google-play.png',
                          width: 300,
                        ),
                      ]
                    ),
                    Expanded(
                      child: Image.asset('assets/illustration.png')
                    )
                  ],
                ),
              ),
              mobileScreen: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Download now or make your own',
                      style: Theme.of(context).textTheme.headline3!
                        .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        children: [
                          Expanded(
                            child: WebText(Strings.data['description'],
                              style: TextStyle(fontSize: 14),
                            )
                          ),
                          Expanded(
                            child: Image.asset('assets/illustration.png')
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, left: 20),
                      child: InkWell(
                        child: Image.asset('assets/github.png',
                          width: 200,
                          color: Colors.white,
                          colorBlendMode: BlendMode.srcIn,
                        ),
                        onTap: () => launchUrl(Uri.parse('https://github.com/nathanielxd/lockie')),
                      ),
                    ),
                    Image.asset('assets/google-play.png',
                      height: 80,
                    ),
                  ]
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}