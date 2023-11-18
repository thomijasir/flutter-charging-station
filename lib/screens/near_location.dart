import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charging_station/consts.dart';
import 'package:flutter_charging_station/models/gas_station.dart';
import 'package:flutter_charging_station/screens/detail_screen.dart';
import 'package:flutter_charging_station/utils/number_utils.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:ripple_wave/ripple_wave.dart';
import 'package:sizer_pro/sizer.dart';

class NearLocationScreen extends StatefulWidget {
  const NearLocationScreen({super.key});

  @override
  State<NearLocationScreen> createState() => _NearLocationScreenState();
}

class _NearLocationScreenState extends State<NearLocationScreen>
    with TickerProviderStateMixin {
  late final MapController mapController;

  @override
  void initState() {
    super.initState();
    mapController = MapController();
  }

  @override
  void dispose() {
    super.dispose();
    mapController;
  }

  static const _startedId = 'AnimatedMapController#MoveStarted';
  static const _InProgressId = 'AnimatedMapController#MoveInProgress';
  static const _finishedId = 'AnimatedMapController#MoveFinished';

  void _animateMapMove(LatLng destLocation, double destZoom) {
    final latTween = Tween(
        begin: mapController.camera.center.latitude,
        end: destLocation.latitude);
    final lngTween = Tween(
        begin: mapController.camera.center.longitude,
        end: destLocation.longitude);
    final zoomTween = Tween(begin: mapController.camera.zoom, end: destZoom);

    final controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));

    final Animation<double> animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    final startIdWithTarget =
        '$_startedId#${destLocation.latitude},${destLocation.longitude},${destZoom}';

    bool hasTriggeredMove = false;

    controller.addListener(() {
      final String id;

      if (animation.value == 1.0) {
        id = _finishedId;
      } else if (!hasTriggeredMove) {
        id = _startedId;
      } else {
        id = _InProgressId;
      }

      hasTriggeredMove |= mapController.move(
          LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
          zoomTween.evaluate(animation),
          id: id);
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      }
      if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leadingWidth: 165,
        leading: Row(
          children: [
            SizedBox(width: 4.w),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(5.w)),
                child: Row(children: [
                  Icon(
                    Icons.arrow_back,
                    size: 8.f,
                  ),
                  Text(
                    'Nearest Location',
                    style: roboto.copyWith(fontSize: 6.f),
                  )
                ]),
              ),
            ),
          ],
        ),
        actions: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                    border: Border.all(color: white)),
                child: Icon(
                  CupertinoIcons.slider_horizontal_3,
                  color: black,
                  size: 8.f,
                ),
              ),
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration:
                      const BoxDecoration(color: red, shape: BoxShape.circle),
                  child: Text(
                    "2",
                    style: roboto.copyWith(color: white),
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 5.w)
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(initialCenter: currentLocation),
            children: [
              TileLayer(
                urlTemplate: mapUri,
              ),
              MarkerLayer(markers: [
                Marker(
                    width: 120,
                    height: 28.sp,
                    point: currentLocation,
                    alignment: Alignment.topCenter,
                    child: RippleWave(
                      child: CustomMarker(
                        props: ICustomMarker(
                            color: Colors.white,
                            w1: Positioned(
                                right: 0,
                                child: Image.asset(
                                  "assets/bmw_i8.png",
                                  width: 28.sp,
                                  height: 28.sp,
                                )),
                            w2: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Icon(
                                Icons.radar_rounded,
                                color: blue,
                                size: 8.f,
                              ),
                            )),
                      ),
                    )),
                ...List.generate(gasStations.length, (i) {
                  final distance = Distance().as(LengthUnit.Meter,
                          currentLocation, gasStations[i].location) /
                      1000;
                  return Marker(
                      width: 25.sp,
                      height: 28.sp,
                      alignment: Alignment.topCenter,
                      point: gasStations[i].location,
                      child: CustomMarker(
                        props: ICustomMarker(
                          color: white,
                          w1: ClipOval(
                            child: Image.asset(
                              gasStations[i].image,
                              fit: BoxFit.cover,
                              width: 23.sp,
                              height: 23.sp,
                            ),
                          ),
                          w2: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            child: Text(
                              '${distance.toStringAsFixed(1)} km',
                              style: roboto.copyWith(
                                  fontSize: 4.f, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ));
                })
              ]),
              ZoomButton(
                alignment: const Alignment(1, -.75),
                maxZoom: 19,
                minZoom: 5,
                padding: 4.w,
              )
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 5.w,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 2.w),
                  child: Card(
                    color: CupertinoColors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.w)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.place_rounded,
                            size: 6.f,
                            color: white,
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Text(
                            currentAddress,
                            style: roboto.copyWith(color: white, fontSize: 4.f),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                CarouselSlider.builder(
                    itemCount: gasStations.length,
                    itemBuilder: (context, index, realIndex) {
                      var isLastIndex = gasStations.length - 1 == index;
                      return Padding(
                        padding: isLastIndex
                            ? EdgeInsets.only(left: 4.w, right: 4.w)
                            : EdgeInsets.only(left: 4.w),
                        child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                            gasStation: gasStations[index],
                                          )));
                            },
                            child: NearestLocationItem(
                                gasStation: gasStations[index])),
                      );
                    },
                    options: CarouselOptions(
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          _animateMapMove(gasStations[index].location,
                              mapController.camera.zoom);
                        },
                        clipBehavior: Clip.none,
                        viewportFraction: .9,
                        aspectRatio: 16 / 7,
                        padEnds: false)),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class ZoomButton extends StatelessWidget {
  final Alignment alignment;
  static const _fitBoundPadding = EdgeInsets.all(2);
  final double minZoom, maxZoom, padding;
  const ZoomButton(
      {super.key,
      required this.alignment,
      required this.minZoom,
      required this.maxZoom,
      required this.padding});

  @override
  Widget build(BuildContext context) {
    final map = MapCamera.of(context);
    return Align(
      alignment: alignment,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(1.w),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              GestureDetector(
                onTap: () {
                  final paddedMapCamera = CameraFit.bounds(
                          bounds: map.visibleBounds, padding: _fitBoundPadding)
                      .fit(map);
                  var zoom = paddedMapCamera.zoom + 1;
                  if (zoom > maxZoom) {
                    zoom = maxZoom;
                  }
                  MapController.of(context).move(paddedMapCamera.center, zoom);
                },
                child: Icon(
                  Icons.add,
                  size: 8.f,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              GestureDetector(
                onTap: () {
                  final paddedMapCamera = CameraFit.bounds(
                          bounds: map.visibleBounds, padding: _fitBoundPadding)
                      .fit(map);
                  var zoom = paddedMapCamera.zoom - 1;
                  if (zoom < minZoom) {
                    zoom = minZoom;
                  }
                  MapController.of(context).move(paddedMapCamera.center, zoom);
                },
                child: Icon(
                  Icons.remove,
                  size: 8.f,
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class NearestLocationItem extends StatelessWidget {
  final GasStation gasStation;
  const NearestLocationItem({super.key, required this.gasStation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration:
          BoxDecoration(color: white, borderRadius: BorderRadius.circular(2.w)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 25.w,
                height: 15.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2.w),
                    image: DecorationImage(
                        image: AssetImage(gasStation.image),
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 3.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 40.w,
                    child: Text(
                      gasStation.name,
                      maxLines: 1,
                      style: roboto.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 6.f,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  Row(
                    children: [
                      RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: roboto.copyWith(
                                  color: blue, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text:
                                        '\Rp.${NumberUtils.stdFormat(gasStation.price)}',
                                    style: roboto.copyWith(fontSize: 6.f)),
                                TextSpan(
                                    text: '/100v',
                                    style: roboto.copyWith(fontSize: 4.f))
                              ])),
                      SizedBox(
                        width: 1.w,
                      ),
                      Icon(
                        Icons.circle,
                        size: 2.f,
                        color: grey,
                      ),
                      SizedBox(
                        width: 1.w,
                      ),
                      RichText(
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          text: TextSpan(
                              style: roboto.copyWith(
                                  color: blue, fontWeight: FontWeight.bold),
                              children: [
                                TextSpan(
                                    text: '8',
                                    style: roboto.copyWith(fontSize: 6.f)),
                                TextSpan(
                                    text: '/10 plug',
                                    style: roboto.copyWith(fontSize: 4.f))
                              ]))
                    ],
                  )
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 8.f,
              ),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location",
                    style: roboto.copyWith(
                        color: black.withOpacity(.5), fontSize: 6.f),
                  ),
                  Text(
                    gasStation.address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: roboto.copyWith(
                        fontSize: 6.f, fontWeight: FontWeight.bold),
                  ),
                ],
              )),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: white,
                    shape: BoxShape.circle,
                    border: Border.all(color: black.withOpacity(.5))),
                child: Icon(
                  Icons.share,
                  color: black,
                  size: 8.f,
                ),
              ),
              const SizedBox(
                width: 6,
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: blue,
                    shape: BoxShape.circle,
                    border: Border.all(color: blue.withOpacity(.5))),
                child: Icon(
                  Icons.directions,
                  color: white,
                  size: 8.f,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ICustomMarker {
  final Color color;
  final Widget w1, w2;
  const ICustomMarker(
      {required this.color, required this.w1, required this.w2});
}

class CustomMarker extends StatelessWidget {
  final ICustomMarker props;
  const CustomMarker({super.key, required this.props});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          Positioned(
              bottom: -5,
              child: Container(
                width: 4,
                height: 10,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white),
              )),
          Container(
              width: 25.sp,
              height: 25.sp,
              padding: const EdgeInsets.all(5),
              decoration:
                  const BoxDecoration(shape: BoxShape.circle, color: white)),
          props.w1,
          Positioned(
            right: -5,
            bottom: 5,
            child: Container(
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(20)),
              child: props.w2,
            ),
          )
        ],
      ),
    );
  }
}
