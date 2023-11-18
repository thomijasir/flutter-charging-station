import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_charging_station/components/Menu.dart';
import 'package:flutter_charging_station/consts.dart';
import 'package:flutter_charging_station/screens/near_location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:sizer_pro/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void handleGetDirection(BuildContext ctx) => {
        Navigator.push(ctx,
            MaterialPageRoute(builder: (context) => const NearLocationScreen()))
      };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white.withOpacity(0.9),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        height: 30.h,
                        width: 100.w,
                        color: black,
                        padding: EdgeInsets.fromLTRB(4.w, 4.w, 4.w, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Good  Morning,\nThomi Jasir",
                                  style: roboto.copyWith(
                                      fontSize: 12.f, color: white, height: 1),
                                ),
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color: white)),
                                      child: Icon(
                                        Icons.notifications_outlined,
                                        color: white,
                                        size: 8.f,
                                      ),
                                    ),
                                    Positioned(
                                      right: -5,
                                      top: -5,
                                      child: Container(
                                        padding: const EdgeInsets.all(3),
                                        decoration: const BoxDecoration(
                                            color: red, shape: BoxShape.circle),
                                        child: Text(
                                          "2",
                                          style: roboto.copyWith(color: white),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              "BMW i8",
                              style:
                                  roboto.copyWith(fontSize: 6.f, color: white),
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: -7.h,
                        right: 0,
                        child: Image.asset(
                          'assets/bmw_i8.png',
                          width: 80.w,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 50.w,
                          child: Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                                color: white,
                                borderRadius: BorderRadius.circular(2.w)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Battery",
                                            style: roboto.copyWith(
                                                fontSize: 8.f,
                                                color: black,
                                                fontWeight: FontWeight.bold)),
                                        Text("Last charge 2w ago",
                                            style: roboto.copyWith(
                                                fontSize: 4.f,
                                                color: black.withOpacity(.4))),
                                      ],
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_right_rounded,
                                      size: 8.f,
                                    )
                                  ],
                                ),
                                const Divider(),
                                const SizedBox(
                                  height: 16,
                                ),
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                                color: grey.shade200)),
                                        const SizedBox(height: 3),
                                        Container(
                                          width: 50,
                                          height: 75,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: grey.shade200),
                                          child: const WaveProgress(
                                              waveColor: blue, progress: 40),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 3.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RichText(
                                              text: TextSpan(
                                                  style: roboto.copyWith(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                TextSpan(
                                                    text: '212',
                                                    style: roboto.copyWith(
                                                        fontSize: 12.f)),
                                                TextSpan(
                                                    text: 'km',
                                                    style: roboto.copyWith(
                                                        fontSize: 6.f))
                                              ])),
                                          const Divider(),
                                          RichText(
                                              text: TextSpan(
                                                  style: roboto.copyWith(
                                                      color: black,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  children: [
                                                TextSpan(
                                                    text: '14',
                                                    style: roboto.copyWith(
                                                        fontSize: 8.f)),
                                                TextSpan(
                                                    text: '%',
                                                    style: roboto.copyWith(
                                                        fontSize: 6.f)),
                                                TextSpan(
                                                    text: 'kv',
                                                    style: roboto.copyWith(
                                                        fontSize: 4.f,
                                                        color: black
                                                            .withOpacity(0.4)))
                                              ])),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  "Saving Mode Battery",
                                  style: roboto.copyWith(
                                    color: black.withOpacity(.4),
                                    fontSize: 4.f,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 37.w,
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(2.w)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.social_distance_rounded,
                                          size: 10.f,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 8.f,
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text('1.345 km',
                                        style: roboto.copyWith(
                                            fontSize: 8.f,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "Total Distance",
                                      style: roboto.copyWith(
                                        color: black.withOpacity(.4),
                                        fontSize: 4.f,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: 2.w),
                              Container(
                                padding: EdgeInsets.all(4.w),
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(2.w)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.cloud,
                                          size: 10.f,
                                        ),
                                        Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 8.f,
                                        )
                                      ],
                                    ),
                                    const Divider(),
                                    Text('24C',
                                        style: roboto.copyWith(
                                            fontSize: 8.f,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "Patchy Cloudy",
                                      style: roboto.copyWith(
                                        color: black.withOpacity(.4),
                                        fontSize: 4.f,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: AspectRatio(
                      aspectRatio: 16 / 7,
                      child: Container(
                        width: 90.w,
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(2.w)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(2.w),
                          child: Stack(
                            alignment: Alignment.centerRight,
                            children: [
                              SizedBox(
                                width: 50.w,
                                child: FlutterMap(
                                    options: MapOptions(
                                        initialCenter: currentLocation),
                                    children: [
                                      TileLayer(
                                        urlTemplate: mapUri,
                                      ),
                                      MarkerLayer(markers: [
                                        Marker(
                                            point: currentLocation,
                                            child: Container(
                                              padding: const EdgeInsets.all(3),
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: blue),
                                              child: Icon(
                                                Icons.near_me,
                                                size: 10.f,
                                                color: white,
                                              ),
                                            ))
                                      ])
                                    ]),
                              ),
                              Positioned(
                                top: -50,
                                left: -50,
                                child: Container(
                                  width: 250,
                                  height: 250,
                                  decoration: const BoxDecoration(
                                      color: white, shape: BoxShape.circle),
                                ),
                              ),
                              Positioned(
                                  top: 5.w,
                                  left: 5.w,
                                  bottom: 5.w,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Find closest\ncharging station",
                                        style: roboto.copyWith(
                                            fontSize: 8.f,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            handleGetDirection(context),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 10),
                                          decoration: BoxDecoration(
                                              color: blue,
                                              borderRadius:
                                                  BorderRadius.circular(4.w)),
                                          child: Text(
                                            'Get Direction',
                                            style:
                                                roboto.copyWith(fontSize: 6.f),
                                          ),
                                        ),
                                      )
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15.h)
                ],
              ),
            ),
            const Positioned(bottom: 0, child: MenuComp())
                .animate()
                .fadeIn()
                .shimmer(),
          ],
        ),
      ),
    );
  }
}

class WaveProgress extends StatefulWidget {
  final Color waveColor;
  final double progress;

  const WaveProgress(
      {super.key, required this.waveColor, required this.progress});

  @override
  State<WaveProgress> createState() => _WaveProgressState();
}

class _WaveProgressState extends State<WaveProgress>
    with TickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2500));
    animationController?.repeat();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController!,
      builder: (context, child) {
        return CustomPaint(
            painter: WaveProgressPainter(
                animationController, widget.waveColor, widget.progress));
      },
    );
  }
}

class WaveProgressPainter extends CustomPainter {
  final Animation<double>? _animation;
  final Color color;
  final double _progress;

  WaveProgressPainter(this._animation, this.color, this._progress)
      : super(repaint: _animation);

  @override
  void paint(Canvas canvas, Size size) {
    Paint waveOne = Paint()..color = color.withOpacity(.5);
    double p = _progress / 100;
    double n = 1.5;
    double amp = 2.0;
    double baseHeight = (1 - p) * size.height;
    Path path = Path();
    path.moveTo(0, baseHeight);
    for (double i = 0; i < size.width; i++) {
      double sinX = i / size.width * 2 * pi * n;
      double sinY = _animation!.value * 2 * pi;
      double baseSin = baseHeight + sin((sinX + sinY + pi * 2) * amp);
      path.lineTo(i, baseSin);
    }
    path.lineTo(size.width, baseHeight);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, waveOne);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// NEXT VIDEO 16.30
// const SizedBox(height: 40)
// Bottom Sheet https://www.youtube.com/watch?v=TXYuaiukw7E
